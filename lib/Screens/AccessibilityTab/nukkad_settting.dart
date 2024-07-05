import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurant_app/Widgets/buttons/mainButton.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:restaurant_app/Widgets/input_fields/textInputField.dart';
import 'package:sizer/sizer.dart';

class NukkadSettingWidget extends StatefulWidget {
  const NukkadSettingWidget({super.key});

  @override
  State<NukkadSettingWidget> createState() => _NukkadSettingWidgetState();
}

class _NukkadSettingWidgetState extends State<NukkadSettingWidget> {
  final ownerNameController = TextEditingController();
  final nukkadAddressController = TextEditingController();
  final nukkadEmailController = TextEditingController();
  String nukkadAddress = '';
  String nukkadEmail = '';
  File? _image;
  List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  List<bool> isOpen = List.generate(7, (index) => false);
  // final ImagePicker imagebannerpath = ImagePicker();
  String? imagebannerpath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ownerNameController.text = "Rahul Kumar";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nukkad Info and settings', style: h4TextStyle),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2.h, color: textGrey3),
                    color: bgColor,
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: textGrey3.withOpacity(0.5), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset:
                            Offset(2, 2), // Offset in the x and y directions
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Choose how people will see your stall',
                        style: body5TextStyle.copyWith(color: textGrey2),
                      ),
                      SizedBox(
                        height: 2.h,
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
                                  width:
                                      45, // Adjust the width and height as needed
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
                      Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: textInputFields(
                          'Owner\'s Full Name',
                          ownerNameController,
                          (String input) {
                            // setState(() {
                            //   ownerName = input;
                            // });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 2.h),
                        width: 100.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 0.7.h),
                        decoration: BoxDecoration(
                          color: colorwarnig.withOpacity(0.3),
                          border: Border.all(width: 0.2.h, color: colorwarnig2),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Note: ',
                                style: body3TextStyle.copyWith(
                                  fontSize: 14,
                                  color: colorFailure,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'This is the name and picture that customers will see on the app.',
                                style: body6TextStyle.copyWith(
                                  letterSpacing: 0.7,
                                  fontSize: 12,
                                  color: textBlack,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: textInputField(
                    'ADDRESS',
                    nukkadAddressController,
                    (String input) {
                      setState(() {
                        nukkadAddress = input;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'nukkad Contact'.toUpperCase(),
                    style: titleTextStyle.copyWith(fontSize: 14.sp),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 2.h),
                  child: textInputField(
                    'Email',
                    nukkadEmailController,
                    (String input) {
                      setState(() {
                        nukkadEmail = input;
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'restaurant operational hours'.toUpperCase(),
                    style: titleTextStyle.copyWith(fontSize: 14.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: textGrey2, width: 0.2.w),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Select restaurant opening days',
                          style: body4TextStyle.copyWith(color: textGrey3),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: SizedBox(
                          width: 100.w,
                          child: Wrap(
                            spacing: 0.5.h,
                            runSpacing: 0.5.h,
                            alignment: WrapAlignment.spaceEvenly,
                            runAlignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: List.generate(
                              (daysOfWeek.length / 2).ceil(),
                              (rowIndex) {
                                int startIndex = rowIndex * 2;
                                int endIndex = startIndex + 1;
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if (startIndex < daysOfWeek.length)
                                      Checkbox(
                                        value: isOpen[startIndex],
                                        onChanged: (newValue) {
                                          setState(() {
                                            isOpen[startIndex] = newValue!;
                                          });
                                        },
                                        activeColor: colorSuccess,
                                      ),
                                    if (startIndex < daysOfWeek.length)
                                      Text(
                                        daysOfWeek[startIndex],
                                        style: body3TextStyle.copyWith(
                                            fontSize: 12.sp),
                                      ),
                                    if (endIndex < daysOfWeek.length)
                                      Checkbox(
                                        value: isOpen[endIndex],
                                        onChanged: (newValue) {
                                          setState(() {
                                            isOpen[endIndex] = newValue!;
                                          });
                                        },
                                        activeColor: colorSuccess,
                                      ),
                                    if (endIndex < daysOfWeek.length)
                                      Text(
                                        daysOfWeek[endIndex],
                                        style: body3TextStyle.copyWith(
                                            fontSize: 12.sp),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Select restaurant opening /closing time',
                          style: body4TextStyle.copyWith(color: textGrey3),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Opening',
                                style: body5TextStyle.copyWith(
                                    color: colorSuccess,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 1.h),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: colorFailure, width: 0.2.w),
                                  boxShadow: [
                                    BoxShadow(
                                      color: colordenger
                                          .withOpacity(0.5), // Shadow color
                                      spreadRadius: 2, // Spread radius
                                      blurRadius: 5, // Blur radius
                                      offset: Offset(0,
                                          2), // Offset in the x and y directions
                                    ),
                                  ],
                                ),
                                child: Stack(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'assets/images/openRes.png',
                                        cacheWidth: 50,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        '09:30 AM',
                                        style: body5TextStyle.copyWith(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 5,
                                    child: Text(
                                      'OPEN',
                                      style: body6TextStyle.copyWith(
                                          color: colorSuccess),
                                    ),
                                  )
                                ]),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Closing',
                                style: body5TextStyle.copyWith(
                                    color: colordenger,
                                    letterSpacing: 1.5,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 1.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 1.h),
                                decoration: BoxDecoration(
                                  color: bgColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: colorFailure, width: 0.2.w),
                                  boxShadow: [
                                    BoxShadow(
                                      color: colordenger
                                          .withOpacity(0.5), // Shadow color
                                      spreadRadius: 2, // Spread radius
                                      blurRadius: 5, // Blur radius
                                      offset: Offset(0,
                                          2), // Offset in the x and y directions
                                    ),
                                  ],
                                ),
                                child: Stack(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.asset(
                                        'assets/images/closeRes.png',
                                        cacheWidth: 50,
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Text(
                                        '10:30 PM',
                                        style: body5TextStyle.copyWith(
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 5,
                                    child: Text(
                                      'CLOSE',
                                      style: body6TextStyle.copyWith(
                                        color: colorFailure,
                                      ),
                                    ),
                                  )
                                ]),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.h,
                  ),
                  child: mainButton(
                      'save details'.toUpperCase(), textWhite, routerChat),
                ),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void routerChat() {
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const ChatScreenWidget(),
    //   ),
    // );
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

  textInputFields(String s, TextEditingController ownerNameController,
      Null Function(String input) param2) {
    // controller.addListener(() {
    //   onInputChanged(controller.text);
    // });

    return Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(7),
      child: TextField(
        enabled: false,
        controller: ownerNameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(color: textGrey2, width: 0.1.h),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: BorderSide(color: textGrey2, width: 0.1.h),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          labelText: "Nukkad name",
          labelStyle: body4TextStyle.copyWith(color: textGrey2),
        ),
        // onChanged: (value) {
        //   onInputChanged(value);
        // },
      ),
    );
  }
}
