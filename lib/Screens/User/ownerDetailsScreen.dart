import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restaurant_app/Controller/Profile/profile_controller.dart';
import 'package:restaurant_app/Screens/User/documentationScreen.dart';
import 'package:restaurant_app/Screens/User/registerScreen.dart';
import 'package:restaurant_app/Widgets/buttons/mainButton.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:restaurant_app/Widgets/customs/User/registrationTimeline.dart';
import 'package:restaurant_app/Widgets/customs/User/uploadWidget.dart';
import 'package:restaurant_app/Widgets/input_fields/numberInputField.dart';
import 'package:restaurant_app/Widgets/input_fields/phoneField.dart';
import 'package:restaurant_app/Widgets/input_fields/textInputField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';

import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

class OwnerDetailsScreen extends StatefulWidget {
  const OwnerDetailsScreen({super.key});

  @override
  State<OwnerDetailsScreen> createState() => _OwnerDetailsScreenState();
}

class _OwnerDetailsScreenState extends State<OwnerDetailsScreen> {
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  Uint8List? _signatureImageBytes;
  File? _image;
  // final ImagePicker imagebannerpath = ImagePicker();
  String? imagebannerpath;
  String? imageSignaturePath;
  String? imagePanPath;
  String? imageAadharFrontPath;
  String? imageAadharBackPath;
  String ownerName = '';
  String ownerEmail = '';
  String ownerPhone = '';
  String currentAddress = '';
  String permanentAddress = '';
  String nukkadPhoneNumber = '';
  final ownerNameController = TextEditingController();
  final ownerEmailController = TextEditingController();
  final ownerPhoneController = TextEditingController();
  final currentAddressController = TextEditingController();
  final permanentAddressController = TextEditingController();

  String aadharNumber = '';
  String panNumber = '';

  final aadharNumberController = TextEditingController();
  final panNumberController = TextEditingController();

  int? _selectedOption;
  bool whatsappConfirmation = false;
  bool isSignatureUploaded = false;
  bool isPanUploaded = false;
  bool isAadharBackUploaded = false;
  bool isAadharUploadeFront = false;

  LocalController _getSavedData = LocalController();
  late Map<String, dynamic> userInfo;
  @override
  void initState() {
    super.initState();
    _checkPermission();
    getUserData();
  }

  Future<void> _checkPermission() async {
    PermissionStatus status = await Permission.camera.status;
    // setState(() {
    //   _status = status;
    // });
    print('Camera Permission Status: $status');

    if (status != PermissionStatus.granted) {
      // If the camera permission is not granted, request it
      await _requestPermission();
    }
  }

  Future<void> _requestPermission() async {
    try {
      PermissionStatus status = await Permission.camera.request();
      if (status == PermissionStatus.granted) {
        // Permission granted, proceed with camera usage
        print('Camera Permission Granted');
      } else {
        // Permission denied, handle accordingly
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: colorFailure,
            content: Text("Camera Permission Denied")));
        print('Camera Permission Denied');
      }
    } catch (e) {
      // Handle any exceptions that occur during the permission request
      print('Error requesting camera permission: $e');
    }
  }

  Future<void> getUserData() async {
    try {
      Map<String, dynamic>? getData = await _getSavedData.getUserInfo();
      setState(() {
        userInfo = getData!;
        nukkadPhoneNumber = userInfo['phoneNumber'];
        ownerNameController.text = userInfo['ownerName'] ?? '';
        ownerPhoneController.text = userInfo['ownerContactNumber'] ?? '';
        currentAddressController.text = userInfo['currentAddress'];
        permanentAddressController.text = userInfo['permananetAddress'] ?? '';
        // aadharNumberController.text =
        //     userInfo['kycDetails']['aadharNumber'] ?? '';
        // panNumberController.text = userInfo['kycDetails']['panNumber'] ?? '';
        ownerEmailController.text = userInfo['ownerEmail'] ?? "";

        // print('ddddddddddddddddddddddddddd$userInfo');
        // isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      // Handle error
    }
  }

  Future<void> saveUserInfo(Map<String, dynamic> userInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.remove('user_info');
    await prefs.setString('user_info', jsonEncode(userInfo));
    print(prefs.getString('user_info'));
  }

  routeDocumentation() {
    if (aadharNumber.isNotEmpty &&
        panNumber.isNotEmpty &&
        ownerEmail.isNotEmpty &&
        ownerName.isNotEmpty) {
      userInfo['ownerPhoto'] = imagebannerpath;
      userInfo['ownerName'] = ownerName;
      userInfo['ownerEmail'] = ownerEmail;
      userInfo['ownerContactNumber'] = ownerPhone;
      userInfo['currentAddress'] = currentAddress;
      userInfo['permananetAddress'] = permanentAddress;
      userInfo['kycDetails'] = {
        'aadharNumber': aadharNumber,
        'panNumber': panNumber,
      };
      userInfo['signature'] = imageSignaturePath;

      // userInfo['nukkadAddress'] = whatsappConfirmation;

      saveUserInfo(userInfo);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const DocumentationScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: colorFailure,
          content: Text("Name, email, Aadhar and pan is required")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const RegistrationScreen(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 20.sp,
          ),
        ),
        title: Text('Owner\'s Photo', style: h4TextStyle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const RegistrationTimeline(pageIndex: 1),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 2.h),
                child:
                    Text('Owner Details'.toUpperCase(), style: titleTextStyle),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Stack(children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: _image != null
                      ? FileImage(_image!) as ImageProvider<Object>?
                      : AssetImage('assets/images/owner.png'),
                ),
                // _image == null
                //     ? Image.asset('assets/images/owner.png')
                //     : Image.file(_image!),
                // Image.asset('assets/images/owner.png'),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()),
                      );
                    },
                    child: Container(
                        width: 45, // Adjust the width and height as needed
                        height: 45,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red
                            // .red, // Adjust the color as needed
                            ),
                        child: Icon(
                          Icons.camera_alt_rounded,
                          // size: 15,
                          color: Colors.white,
                        )),
                  ),
                ),
              ]),
            ),
            Container(
              margin: EdgeInsets.only(top: 3.h, left: 3.w, right: 3.w),
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: textGrey2, width: 0.2.w),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: textInputField(
                        'Owner\'s Full Name', ownerNameController,
                        (String input) {
                      setState(() {
                        ownerName = input;
                      });
                    }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 2.h),
                    child: textInputField(
                        'Owner\'s Email Address', ownerEmailController,
                        (String input) {
                      setState(() {
                        ownerEmail = input;
                      });
                    }),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child:
                          buildRadioButton(0, 'Same as restaurant mobile no.')),
                  PhoneField(
                    controller: ownerPhoneController,
                    onPhoneNumberChanged: (String number) {
                      setState(() {
                        ownerPhone = number;
                      });
                    },
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: CheckboxListTile(
                      value: whatsappConfirmation,
                      onChanged: (value) {
                        setState(() {
                          whatsappConfirmation = value ?? false;
                          print('Whatsapp confirmation: $whatsappConfirmation');
                        });
                      },
                      title: Text('Yes, this is my whatsapp no.',
                          style: body4TextStyle),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: colorSuccess,
                    ),
                  ),
                  textInputField('Current Address', currentAddressController,
                      (String input) {
                    setState(() {
                      // currentAddressController.text = input;
                      currentAddress = input;
                    });
                  }),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                        width: 80.w,
                        child: buildRadioButton(1, 'Same as current address.')),
                  ),
                  SizedBox(width: 5.w),
                  textInputField(
                      'Permanent Address', permanentAddressController,
                      (String input) {
                    setState(() {
                      permanentAddress = input;
                    });
                  }),
                  SizedBox(height: 3.h),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                child: Text('KYC Details'.toUpperCase(), style: titleTextStyle),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 3.w, right: 3.w),
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: textGrey2, width: 0.2.w),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 1.h, 0, 0.5.h),
                    child: numberInputField(
                        'Aadhaar Number', aadharNumberController,
                        (String input) {
                      setState(() {
                        aadharNumber = input;
                      });
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Spacer(),
                      verified(),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 1.h, 0, 0.5.h),
                    child: numberInputField('PAN Number', panNumberController,
                        (String input) {
                      setState(() {
                        panNumber = input;
                      });
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Spacer(),
                      verified(),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3.h, left: 3.w, right: 3.w),
              padding: EdgeInsets.only(left: 3.w, bottom: 5.h, right: 3.w),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Upload Aadhar Front'.toUpperCase(),
                            style: titleTextStyle,
                          ),
                          SizedBox(width: 1.w),
                          SvgPicture.asset('assets/icons/upload_icon.svg'),
                        ],
                      ),
                    ),
                  ),
                  uploadWidget(onFilePicked: _handleAadharFrontPicked),
                  isAadharUploadeFront
                      ? Text(
                          '${imageAadharFrontPath?.split('/').last} selected!',
                          style: body4TextStyle.copyWith(color: colorSuccess),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3.h, left: 3.w, right: 3.w),
              padding: EdgeInsets.only(left: 3.w, bottom: 5.h, right: 3.w),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Upload Aadhar Back'.toUpperCase(),
                            style: titleTextStyle,
                          ),
                          SizedBox(width: 1.w),
                          SvgPicture.asset('assets/icons/upload_icon.svg'),
                        ],
                      ),
                    ),
                  ),
                  uploadWidget(onFilePicked: _handleAadharBackPicked),
                  isAadharBackUploaded
                      ? Text(
                          '${imageAadharBackPath?.split('/').last} selected!',
                          style: body4TextStyle.copyWith(color: colorSuccess),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 3.h, left: 3.w, right: 3.w),
              padding: EdgeInsets.only(left: 3.w, bottom: 5.h, right: 3.w),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Upload PAN'.toUpperCase(),
                            style: titleTextStyle,
                          ),
                          SizedBox(width: 1.w),
                          SvgPicture.asset('assets/icons/upload_icon.svg'),
                        ],
                      ),
                    ),
                  ),
                  uploadWidget(onFilePicked: _handlePanPicked),
                  isPanUploaded
                      ? Text(
                          '${imagePanPath?.split('/').last} selected!',
                          style: body4TextStyle.copyWith(color: colorSuccess),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
            Text(
              'Signature hear'.toUpperCase(),
              style: titleTextStyle,
            ),
            Column(
                children: [
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                          child: SfSignaturePad(
                              key: signatureGlobalKey,
                              backgroundColor: Colors.white,
                              strokeColor: Colors.black,
                              minimumStrokeWidth: 1.0,
                              maximumStrokeWidth: 4.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)))),
                  SizedBox(height: 10),
                  Row(children: <Widget>[
                    TextButton(
                      child: Text('Upload Signature '),
                      onPressed: _handleSaveButtonPressed,
                    ),
                    TextButton(
                      child: Text('Clear'),
                      onPressed: _handleClearButtonPressed,
                    )
                  ], mainAxisAlignment: MainAxisAlignment.spaceEvenly)
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center),
            SizedBox(height: 2.h),
            // Show the captured signature image
            _showSignatureImage(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
              child: mainButton('Save Details', textWhite, routeDocumentation),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showSignatureImage() {
    if (_signatureImageBytes != null) {
      return Image.memory(_signatureImageBytes!);
    } else {
      return Text('No signature captured');
    }
  }

  void _handleSignaturePicked(bool isPicked, String? filePath) {
    setState(() {
      isSignatureUploaded = isPicked;
      imageSignaturePath = filePath;
    });
  }

  void _handlePanPicked(bool isPicked, String? filePath) {
    setState(() {
      isPanUploaded = isPicked;
      imagePanPath = filePath;
    });
  }

  void _handleAadharFrontPicked(bool isPicked, String? filePath) {
    setState(() {
      isAadharUploadeFront = isPicked;
      imageAadharFrontPath = filePath;
    });
  }

  void _handleAadharBackPicked(bool isPicked, String? filePath) {
    setState(() {
      isAadharBackUploaded = isPicked;
      imageAadharBackPath = filePath;
    });
  }

  void _handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
  }

  Future<void> _handleSaveButtonPressed() async {
    if (signatureGlobalKey.currentState != null) {
      // Retrieve the drawn signature as a data blob
      final data =
          await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
      final byteData = await data.toByteData(format: ui.ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();
      final base64String = base64Encode(bytes);
      // print('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb$base64String');
      setState(() {
        _signatureImageBytes = bytes;
        imageSignaturePath = base64String;
      });
    }
  }

  // void _handleSaveButtonPressed() async {
  //   final data =
  //       await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
  //   final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
  //   await Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (BuildContext context) {
  //         return Scaffold(
  //           appBar: AppBar(),
  //           body: Center(
  //             child: Container(
  //               color: Colors.grey[300],
  //               child: Image.memory(bytes!.buffer.asUint8List()),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget buildRadioButton(int value, String title) {
    return RadioListTile<int>(
      value: value,
      groupValue: _selectedOption,
      onChanged: (newValue) {
        setState(() {
          // ownerPhoneController.text = nukkadPhoneNumber;
          _selectedOption = newValue;
          if (newValue != null && title == 'Same as current address.') {
            permanentAddress = currentAddressController.text;
            permanentAddressController.text = currentAddressController.text;
          } else {
            permanentAddressController.clear();
          }
          if (newValue == 0) {
            ownerPhoneController.text = nukkadPhoneNumber;
            ownerPhone = nukkadPhoneNumber;
          } else {
            ownerPhoneController.clear();
            ownerPhone = '';
          }
        });
      },
      toggleable: true,
      title: Text(
        title,
        style: body4TextStyle.copyWith(
            fontSize: 11.sp, fontWeight: FontWeight.w400),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: primaryColor,
    );
  }

  Widget verified() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 1.w),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/verified_icon.svg',
            color: colorSuccess,
          ),
          Text(
            'Verified',
            style: body5TextStyle.copyWith(
              color: colorSuccess,
              fontWeight: FontWeight.w100,
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton.icon(
                  icon: const Icon(Icons.camera),
                  onPressed: () {
                    // pickImage();
                    pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  label: const Text("Camera"),
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.image),
                  onPressed: () {
                    // pickImage();
                    pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  label: const Text("Gallery"),
                ),
              ])
        ],
      ),
    );
  }

  Future pickImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        imagebannerpath = _image!.path;
      });
      // setState(() {
      //   _image = File(pickedFile.path);
      // });
    }
  }
}
