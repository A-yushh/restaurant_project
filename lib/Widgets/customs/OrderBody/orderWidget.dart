import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:restaurant_app/Widgets/customs/HomeBody/viewTotalBill.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import '../../../Screens/Orders/trackRiderScreen.dart';

class OrderWidget extends StatefulWidget {
  final bool type;
  Map<String, dynamic>? order;
  String? uid;
  OrderWidget({super.key, required this.type, this.uid, this.order});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool isDeclined = false;
  bool isAccepted = false;
  bool isPrepared = false;
  bool isMarkedReady = false;
  List<dynamic> items = [];
  bool isLoading = false;
  String? orderId;
  String? uid;
  @override
  void initState() {
    // TODO: implement initState
    if (widget.order != null) {
      // Initialize items only if widget.order is not null
      items = widget.order!['items'] ?? [];
      orderId = widget.order!['orderId'];
      uid = widget.uid;
    } else {
      items = [];
    }
    super.initState();
  }

  Future<void> orderDeleted() async {
    setState(() {
      isLoading = true;
    });
    try {
      var baseUrl = dotenv.env['BASE_URL'];
      final response =
          await http.delete(Uri.parse('$baseUrl/order/orders/$uid/$orderId'));
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData != null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: colorSuccess,
              content: Text("Menu item deleted successfully")));
          setState(() {
            isLoading = false;
            isDeclined = true;
            isAccepted = false;
            isPrepared = false;
            isMarkedReady = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: colorFailure,
                content: Text(responseData['message'])),
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: colorFailure,
            content: Text("Failed to order delete")));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: colorFailure,
          content: Text("Error:  Internal Server Error")));
    }
  }

  Future<void> startOnWay() async {
    setState(() {
      isLoading = true;
    });
    try {
      var baseUrl = dotenv.env['BASE_URL'];
      var reqData = {
        "updateData": {"status": "On the way"}
      };
      String requestBody = jsonEncode(reqData);
      final response =
          await http.put(Uri.parse('$baseUrl/order/orders/$uid/$orderId'),
              headers: {
                'Content-Type': 'application/json',
              },
              body: requestBody);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData != null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: colorSuccess,
              content: Text("Order start ride successfully")));
          setState(() {
            widget.order = responseData['order'];
            isDeclined = false;
            isAccepted = true;
            isPrepared = true;
            isMarkedReady = true;
            isLoading = false;
          });
          print(widget.order);
        } else {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: colorFailure,
                content: Text(responseData['message'])),
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: colorFailure,
            content: Text("Failed to start ride order")));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: colorFailure,
          content: Text("Error:  Internal Server Error")));
    }
  }

  Future<void> startPreparing() async {
    setState(() {
      isLoading = true;
    });
    try {
      var baseUrl = dotenv.env['BASE_URL'];
      var reqData = {
        "updateData": {"status": "Ready"}
      };
      String requestBody = jsonEncode(reqData);
      final response =
          await http.put(Uri.parse('$baseUrl/order/orders/$uid/$orderId'),
              headers: {
                'Content-Type': 'application/json',
              },
              body: requestBody);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData != null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: colorSuccess,
              content: Text("Order item start Preparing successfully")));
          setState(() {
            widget.order = responseData['order'];
            isDeclined = false;
            isAccepted = true;
            isLoading = false;
            isPrepared = true;
            isMarkedReady = false;
          });
          print(widget.order);
        } else {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: colorFailure,
                content: Text(responseData['message'])),
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: colorFailure,
            content: Text("Failed to start Preparing order")));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: colorFailure,
          content: Text("Error:  Internal Server Error")));
    }
  }

  Future<void> acceptOrder() async {
    setState(() {
      isLoading = true;
    });
    try {
      var baseUrl = dotenv.env['BASE_URL'];
      var reqData = {
        "updateData": {"status": "Accepted"}
      };
      String requestBody = jsonEncode(reqData);
      final response =
          await http.put(Uri.parse('$baseUrl/order/orders/$uid/$orderId'),
              headers: {
                'Content-Type': 'application/json',
              },
              body: requestBody);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData != null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: colorSuccess,
              content: Text("Order item update successfully")));
          setState(() {
            widget.order = responseData['order'];
            isDeclined = false;
            isAccepted = true;
            isPrepared = false;
            isMarkedReady = false;
            isLoading = false;
          });
          print(widget.order);
        } else {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: colorFailure,
                content: Text(responseData['message'])),
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: colorFailure,
            content: Text("Failed to update order")));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: colorFailure,
          content: Text("Error:  Internal Server Error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    bool type = widget.type;
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          )
        : Container(
            padding: EdgeInsets.only(top: 2.h),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  color: textWhite,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: textGrey3, width: 0.2.h),
                  boxShadow: [
                    BoxShadow(
                      color: textGrey3.withOpacity(0.5), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: Offset(0, 3), // Offset in the x and y directions
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "ID: #${widget.order!['orderId'] != null ? widget.order!['orderId'] : 0}",
                                style: body4TextStyle.copyWith(
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 3.w, vertical: 0.2.h),
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  widget.order!['status'] != null
                                      ? widget.order!['status']
                                      : '',
                                  style: body4TextStyle.copyWith(
                                      color: textWhite,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 35.w,
                                padding: EdgeInsets.symmetric(vertical: 0.4.h),
                                child: Text(
                                  'Today, ${widget.order!['time'] != null ? widget.order!['time'] : ''}',
                                  style:
                                      body5TextStyle.copyWith(color: textGrey2),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Container(
                                width: 48.w,
                                padding: EdgeInsets.symmetric(vertical: 0.4.h),
                                child: Text(
                                  'By ${widget.order!['orderByName'] != null ? widget.order!['orderByName'] : ''}',
                                  style:
                                      body5TextStyle.copyWith(color: textGrey2),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 35.w,
                                padding: EdgeInsets.symmetric(vertical: 0.4.h),
                                child: Text(
                                  'Order total : ₹202',
                                  style: body5TextStyle.copyWith(
                                    color: textBlack,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: colorSuccess, width: 0.2.h),
                                  color: textGrey2,
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.2.h, horizontal: 3.w),
                                child: Text(
                                  'COD',
                                  style: body5TextStyle.copyWith(
                                      color: textBlack,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: textGrey2,
                            thickness: 0.2.h,
                          ),
                          SizedBox(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: items.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return _buildOrderDetailsWidget(items[index]);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    type
                        ? _buildOrderStatusWidget()
                        : GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ViewTotalBillWidget()),
                              );
                              // ViewTotalBillWidget
                            },
                            child: Container(
                              height: 6.h,
                              width: 100.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 1.h),
                              decoration: const BoxDecoration(
                                color: textGrey1,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(9),
                                  bottomRight: Radius.circular(9),
                                ),
                              ),
                              child: Text(
                                'View Reciept',
                                style: h5TextStyle.copyWith(color: textWhite),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
  }
  //  Widget _buildOrderStatusWidget() {
  //   if (isDeclined == true) {
  //     return _buildDeclinedWidget();
  //   } else if (isAccepted == false &&
  //       isPrepared == false &&
  //       isMarkedReady == false) {
  //     return _buildPendingWidget();
  //   } else if (isAccepted == true &&
  //       isPrepared == false &&
  //       isMarkedReady == false) {
  //     return _buildPreparedWidget();
  //   } else if (isAccepted == true &&
  //       isPrepared == true &&
  //       isMarkedReady == false) {
  //     return _buildMarkReadyWidget();
  //   } else {
  //     return _buildTrackRideWidget();
  //   }

  Widget _buildOrderStatusWidget() {
    if (widget.order!['status'] == 'Canceled') {
      return _buildDeclinedWidget();
    } else if (widget.order!['status'] == 'Pending') {
      return _buildPendingWidget();
    } else if ((widget.order!['status'] == 'Accepted')) {
      return _buildPreparedWidget();
    } else if (widget.order!['status'] == 'Ready') {
      return _buildMarkReadyWidget();
    } else {
      return _buildTrackRideWidget();
    }
  }

  Widget _buildOrderDetailsWidget(dynamic item) {
    return SizedBox(
      width: 45.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '${item['itemQuantity']} x',
            style: body4TextStyle,
          ),
          SizedBox(width: 6.w),
          Text(
            '${item['itemName']}',
            style: body4TextStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildDeclinedWidget() {
    return Container(
      height: 6.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
      decoration: const BoxDecoration(
        color: colorFailure,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(9),
          bottomRight: Radius.circular(9),
        ),
      ),
      child: Text(
        'Declined',
        style: h5TextStyle.copyWith(color: textWhite),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildPendingWidget() {
    return SizedBox(
      height: 6.h,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              orderDeleted();
            },
            child: Container(
              height: 6.h,
              width: 44.6.w,
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              decoration: const BoxDecoration(
                color: textGrey1,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(9),
                ),
              ),
              child: Text(
                'Decline',
                style: h5TextStyle.copyWith(color: textWhite),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              acceptOrder();
            },
            child: Container(
              height: 6.h,
              width: 44.5.w,
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              decoration: const BoxDecoration(
                color: colorSuccess,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(9),
                ),
              ),
              child: Text(
                'Accept',
                style: h5TextStyle.copyWith(color: textWhite),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreparedWidget() {
    return GestureDetector(
      onTap: () {
        startPreparing();
      },
      child: Container(
        height: 6.h,
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
        decoration: const BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(9),
            bottomRight: Radius.circular(9),
          ),
        ),
        child: Text(
          'Start Preparing',
          style: h5TextStyle.copyWith(color: textWhite),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildMarkReadyWidget() {
    return SizedBox(
      height: 6.h,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TrackRiderScreen()));
              });
            },
            child: Container(
              height: 6.h,
              width: 44.6.w,
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              decoration: BoxDecoration(
                color: textWhite,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(9),
                ),
                border: Border.all(color: primaryColor, width: 0.2.h),
              ),
              child: Text(
                'Track Rider',
                style: h5TextStyle.copyWith(color: primaryColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              startOnWay();
            },
            child: Container(
              height: 6.h,
              width: 44.5.w,
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
              decoration: const BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(9),
                ),
              ),
              child: Text(
                'Mark Ready',
                style: h5TextStyle.copyWith(color: textWhite),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackRideWidget() {
    return Container(
      child: GestureDetector(
        onTap: () {
          setState(() {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TrackRiderScreen(),
              ),
            );
          });
        },
        child: Container(
          height: 6.h,
          width: 100.w,
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(9),
              bottomRight: Radius.circular(9),
            ),
          ),
          child: Text(
            'Track Rider',
            style: h5TextStyle.copyWith(color: textWhite),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
