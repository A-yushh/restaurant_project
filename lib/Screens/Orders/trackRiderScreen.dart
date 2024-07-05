import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:sizer/sizer.dart';

class TrackRiderScreen extends StatefulWidget {
  const TrackRiderScreen({super.key});

  @override
  State<TrackRiderScreen> createState() => _TrackRiderScreenState();
}

class _TrackRiderScreenState extends State<TrackRiderScreen> {
  // late GoogleMapController mapController;
  // double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  // double _destLatitude = 6.849660, _destLongitude = 3.648190;
  // double _originLatitude = 26.48424, _originLongitude = 50.04551;
  // double _destLatitude = 26.46423, _destLongitude = 50.06358;
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyCm4zxzOxxfs6XnSdTUgcSnkWDw-uSQ75g";
  bool _isLoading = true;
  late GoogleMapController _controller;
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
        _isLoading = false;
        _addMarker(
            LatLng(_currentPosition.latitude, _currentPosition.longitude),
            "origin",
            BitmapDescriptor.defaultMarker);

        /// destination marker
        _addMarker(
            LatLng(_currentPosition.latitude + 0.1,
                _currentPosition.longitude + 0.1),
            "destination",
            BitmapDescriptor.defaultMarkerWithHue(90));
        _getPolyline();
      });
      // print("Current Location: $_currentPosition");
    } catch (e) {
      print('Error: $e');
    }
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 5,
    );

    setState(() {
      polylines[id] = polyline;
    });
  }
  // _addPolyLine() {
  //   PolylineId id = PolylineId("poly");
  //   Polyline polyline = Polyline(
  //       polylineId: id, color: Colors.red, points: polylineCoordinates);

  //   setState(() {
  //     polylines[id] = polyline;
  //   });
  // }

  _getPolyline() async {
    // print('gggggggggggggggggggggggggggggggggggg');
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(_currentPosition.latitude, _currentPosition.longitude),
      PointLatLng(
          _currentPosition.latitude + 0.1, _currentPosition.longitude + 0.1),
      travelMode: TravelMode.driving,
      // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
    );
    print(result.points);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }

  Future<void> _goToMyLocation() async {
    if (_currentPosition != null && _controller != null) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target:
                LatLng(_currentPosition.latitude, _currentPosition.longitude),
            zoom: 15.0,
          ),
        ),
      );
    }
    _getPolyline();
  }

  @override
  void dispose() {
    _controller.dispose(); // Dispose of the GoogleMapController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track Rider', style: h4TextStyle),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 19.sp,
            color: Colors.black,
          ),
        ),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              fit: StackFit.expand,
              // alignment: AlignmentDirectional.bottomStart,
              children: <Widget>[
                _currentPosition != null
                    ? GoogleMap(
                        mapType: MapType.terrain,
                        myLocationEnabled: true,
                        initialCameraPosition: CameraPosition(
                          target: LatLng(_currentPosition.latitude,
                              _currentPosition.longitude),
                          zoom: 15.0,
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _controller = controller;
                        },
                        markers: Set<Marker>.of(markers.values),
                        tiltGesturesEnabled: true,
                        compassEnabled: true,
                        scrollGesturesEnabled: true,
                        zoomGesturesEnabled: true,
                        // markers: Set<Marker>.of(markers.values),
                        polylines: Set<Polyline>.of(polylines.values),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
                Positioned(
                  top: 20.w,
                  right: 10.w,
                  child: IconButton(
                    icon: Icon(
                      Icons.my_location,
                      color: Color.fromARGB(255, 238, 22, 10),
                    ),
                    onPressed: _goToMyLocation,
                  ),
                ),
              ],
            ),
    );
  }
}
