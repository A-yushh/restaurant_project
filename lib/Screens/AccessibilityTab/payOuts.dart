// import 'dart:js_util';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:restaurant_app/homeScreen.dart';
import 'package:sizer/sizer.dart';

class PayOutsWidget extends StatefulWidget {
  const PayOutsWidget({super.key});

  @override
  State<PayOutsWidget> createState() => _PayOutsWidgetState();
}

class _PayOutsWidgetState extends State<PayOutsWidget> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Payouts', style: h4TextStyle),
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
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Pending payouts'.toUpperCase(),
                    style: titleTextStyle,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Payout of this week will be settled by the end of this week',
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
                Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: bgColor,
                    border: Border.all(width: 0.2.h, color: textGrey3),
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: textGrey3.withOpacity(0.3), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset:
                            Offset(0, 3), // Offset in the x and y directions
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              ' Estimated payout',
                              style: body5TextStyle.copyWith(
                                  fontSize: 12,
                                  color: textBlack,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                            ),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.2.h, color: colordenger),
                              color: colordenger,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                            ),
                            child: Text(
                              'Pending',
                              style: body5TextStyle.copyWith(
                                  color: textWhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.start,
                            ),
                          )

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
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '₹550',
                          style: h1TextStyle.copyWith(color: primaryColor),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Divider(
                        color: primaryColor,
                        thickness: 0.2.h,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Time period',
                            style: body4TextStyle,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            '11 mar - 18 mar 2024',
                            style: h6TextStyle,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Est. date of recieval',
                            style: body4TextStyle,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            '18 mar 2024',
                            style: h6TextStyle,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total orders completed',
                            style: body4TextStyle,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            '18',
                            style: h6TextStyle,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Past payouts'.toUpperCase(),
                  style: titleTextStyle,
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
                      decoration: BoxDecoration(
                        // color: colorwarnig.withOpacity(0.3),
                        border: Border.all(width: 0.2.h, color: primaryColor),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text('Download Invoice',
                          textAlign: TextAlign.center,
                          style: body4TextStyle.copyWith(color: primaryColor)),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 1.5.h),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        border: Border.all(width: 0.2.h, color: primaryColor),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text(
                        '10 Feb - 10 Mar 2024',
                        textAlign: TextAlign.center,
                        style: body4TextStyle.copyWith(color: textWhite),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: bgColor,
                    border: Border.all(width: 0.2.h, color: textGrey3),
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: textGrey3.withOpacity(0.3), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset:
                            Offset(0, 3), // Offset in the x and y directions
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              ' Estimated payout',
                              style: body5TextStyle.copyWith(
                                  fontSize: 12,
                                  color: textBlack,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                            ),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.2.h, color: colorSuccess),
                              color: colorSuccess,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                            ),
                            child: Text(
                              'Paid',
                              style: body5TextStyle.copyWith(
                                  color: textWhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.start,
                            ),
                          )

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
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '₹550',
                          style: h1TextStyle.copyWith(color: primaryColor),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Divider(
                        color: primaryColor,
                        thickness: 0.2.h,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Time period',
                            style: body4TextStyle,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            '11 mar - 18 mar 2024',
                            style: h6TextStyle,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Est. date of recieval',
                            style: body4TextStyle,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            '18 mar 2024',
                            style: h6TextStyle,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total orders completed',
                            style: body4TextStyle,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            '18',
                            style: h6TextStyle,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
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
                    color: bgColor,
                    border: Border.all(width: 0.2.h, color: textGrey3),
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: textGrey3.withOpacity(0.3), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset:
                            Offset(0, 3), // Offset in the x and y directions
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              ' Estimated payout',
                              style: body5TextStyle.copyWith(
                                  fontSize: 12,
                                  color: textBlack,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 3.w,
                            ),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.2.h, color: colorSuccess),
                              color: colorSuccess,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                            ),
                            child: Text(
                              'Paid',
                              style: body5TextStyle.copyWith(
                                  color: textWhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.start,
                            ),
                          )

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
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '₹750',
                          style: h1TextStyle.copyWith(color: primaryColor),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Divider(
                        color: primaryColor,
                        thickness: 0.2.h,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Time period',
                            style: body4TextStyle,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            '11 mar - 18 mar 2024',
                            style: h6TextStyle,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Est. date of recieval',
                            style: body4TextStyle,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            '18 mar 2024',
                            style: h6TextStyle,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total orders completed',
                            style: body4TextStyle,
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            '18',
                            style: h6TextStyle,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     vertical: 2.h,
                //   ),
                //   child: mainButton(
                //       'proceed to pay'.toUpperCase(), textWhite, createOffer),
                // ),
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
