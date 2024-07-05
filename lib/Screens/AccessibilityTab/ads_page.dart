// import 'dart:js_util';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/Widgets/buttons/mainButton.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:restaurant_app/Widgets/input_fields/numberInputField.dart';
import 'package:restaurant_app/homeScreen.dart';
import 'package:sizer/sizer.dart';

class AdsPage extends StatefulWidget {
  const AdsPage({super.key});

  @override
  State<AdsPage> createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String amountValue = '';

  final amountValueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var buttonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Color(0xff35BA2A)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10.0), // Adjust the curve as needed
        ),
      ),
    );
    var redButtonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Color(0xffFF0000)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Ads', style: h4TextStyle),
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
                Text(
                  'Create Effective ads for your nukkad to increase nukkad visibility and growth',
                  style: body3TextStyle.copyWith(
                    fontSize: 12,
                    color: textGrey2,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Create a Ad'.toUpperCase(),
                    style: body3TextStyle.copyWith(
                      letterSpacing: 0.7,
                      fontSize: 15,
                      color: textBlack,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  maxLines: 1,
                  'Select duration ',
                  style: body4TextStyle.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Select the starting and ending dates for your ads',
                  style: body3TextStyle.copyWith(
                    fontSize: 12,
                    color: textGrey2,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 1.5.h),
                      width: 43.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor, width: 0.2.h),
                        borderRadius: BorderRadius.circular(10),
                        color: textWhite,
                      ),
                      child: GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Start Date',
                              style: h5TextStyle.copyWith(
                                color: primaryColor,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 30,
                              color: primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.w,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 1.5.h),
                      width: 43.w,
                      decoration: BoxDecoration(
                        border: Border.all(color: primaryColor, width: 0.2.h),
                        borderRadius: BorderRadius.circular(10),
                        color: primaryColor,
                      ),
                      child: GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'End Date',
                              style: h5TextStyle.copyWith(
                                color: textWhite,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              size: 30,
                              color: textWhite,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Divider(
                  color: textGrey2,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Set Budget amount ',
                  style: h5TextStyle.copyWith(
                    letterSpacing: 0.7,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Select the starting and ending dates for your ads',
                  style: body3TextStyle.copyWith(
                    fontSize: 12,
                    color: textGrey2,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: numberInputField(
                      'enter amount'.toUpperCase(), amountValueController,
                      (String input) {
                    setState(() {
                      amountValue = input;
                    });
                  }),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'your estimated benefits'.toUpperCase(),
                    style: body3TextStyle.copyWith(
                      letterSpacing: 0.7,
                      fontSize: 15,
                      color: textBlack,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2.h, color: primaryColor),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          maxLines: 1,
                          ' ₹350',
                          style: body4TextStyle.copyWith(
                              fontSize: 18,
                              color: primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      VerticalDivider(),
                      // Expanded(
                      //   flex: 1,
                      //   child: Container(
                      //     width: 50.w,
                      //     child: Image.asset(
                      //       'assets/images/offer_img.png',
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2.h, color: primaryColor),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          maxLines: 1,
                          ' ₹350',
                          style: body4TextStyle.copyWith(
                              fontSize: 18,
                              color: primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      VerticalDivider(),
                      // Expanded(
                      //   flex: 1,
                      //   child: Container(
                      //     width: 50.w,
                      //     child: Image.asset(
                      //       'assets/images/offer_img.png',
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2.h, color: primaryColor),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          maxLines: 1,
                          ' ₹350',
                          style: body4TextStyle.copyWith(
                              fontSize: 18,
                              color: primaryColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.h,
                  ),
                  child: mainButton(
                      'proceed to pay'.toUpperCase(), textWhite, createOffer),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  createOffer() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}
