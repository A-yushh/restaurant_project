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
import 'package:restaurant_app/Widgets/input_fields/textInputField.dart';
import 'package:restaurant_app/homeScreen.dart';
import 'package:sizer/sizer.dart';

class PromotionsPage extends StatefulWidget {
  const PromotionsPage({super.key});

  @override
  State<PromotionsPage> createState() => _PromotionsPageState();
}

class _PromotionsPageState extends State<PromotionsPage> {
  String couponCode = '';
  String discount = '';
  String flatRsOff = '';
  String minOrderValue = '';
  String maxDiscount = '';

  final couponCodeController = TextEditingController();
  final discountController = TextEditingController();
  final flatRsOffController = TextEditingController();
  final orderValueController = TextEditingController();
  final maxDiscountController = TextEditingController();
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
          borderRadius:
              BorderRadius.circular(10.0), // Adjust the curve as needed
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Promotions', style: h4TextStyle),
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
                  'Create exciting offers on your restaurant to boost sales and more customer interaction',
                  style: body3TextStyle.copyWith(
                    fontSize: 12,
                    color: Color(0xFFB8B8B8),
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Trending offers'.toUpperCase(),
                  style: body3TextStyle.copyWith(
                    letterSpacing: 0.7,
                    fontSize: 15,
                    color: Colors.black,
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
                    border: Border.all(width: 0.2.h, color: primaryColor),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xffFFED47),
                        Color(0xffFF5D02),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.3), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset:
                            Offset(2, 2), // Offset in the x and y directions
                      ),
                    ],
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  maxLines: 2,
                                  'Offer a Free Dish on orders above ₹350',
                                  style: body4TextStyle.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  'Increase costumer order value and your growth',
                                  style: body5TextStyle.copyWith(
                                      color: Color(0Xff0047FF),
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                ElevatedButton(
                                    onPressed: () {},
                                    style: buttonStyle,
                                    child: Text(
                                      'Activate',
                                      style: body4TextStyle.copyWith(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ))
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: 50.w,
                              child: Image.asset(
                                'assets/images/offer_img.png',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // SizedBox(
                //   height: 4.h,
                // ),
                // ValidSubscribeCard(),
                // Align(
                //   alignment: Alignment.center,
                //   child: Padding(
                //     padding: EdgeInsets.only(top: 3.h, bottom: 2.h),
                //     child: Text(
                //       'You can use wallet cash to renew your subscription after it expirres to continue recieving orders.',
                //       style: body5TextStyle.copyWith(
                //           fontWeight: FontWeight.w600),
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Ongoing offers'.toUpperCase(),
                  style: body3TextStyle.copyWith(
                    letterSpacing: 1.5,
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  // width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.2.h, color: textGrey3),
                    color: Color(0xffF1FFF0),
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: [
                      BoxShadow(
                        color: textGrey2.withOpacity(0.3), // Shadow color
                        spreadRadius: 2, // Spread radius
                        blurRadius: 5, // Blur radius
                        offset:
                            Offset(2, 2), // Offset in the x and y directions
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 45.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              maxLines: 2,
                              'Free Dish',
                              style: body3TextStyle.copyWith(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            Text(
                              'On orders above ₹350',
                              style: body5TextStyle.copyWith(
                                  color: Color(0Xff35BA2A),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                            ElevatedButton(
                                onPressed: () {},
                                style: redButtonStyle,
                                child: Text(
                                  'Deactivate',
                                  style: body5TextStyle.copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'recommended offers'.toUpperCase(),
                  style: body3TextStyle.copyWith(
                    letterSpacing: 0.7,
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 2.h,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        // width: 100.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.2.h, color: Color(0xffFAFF00)),
                          color: Color(0xffFEFFCF),
                          borderRadius: BorderRadius.circular(7),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  colorwarnig.withOpacity(0.3), // Shadow color
                              spreadRadius: 2, // Spread radius
                              blurRadius: 5, // Blur radius
                              offset: Offset(
                                  2, 2), // Offset in the x and y directions
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: 40.w,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    maxLines: 2,
                                    'Free Dish',
                                    style: body3TextStyle.copyWith(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  Text(
                                    'On orders above ₹350',
                                    style: body5TextStyle.copyWith(
                                        color: Color(0XffFF4C00),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.start,
                                  ),
                                  SizedBox(
                                    height: 1.5.h,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {},
                                      style: buttonStyle,
                                      child: Text(
                                        'Activate',
                                        style: body5TextStyle.copyWith(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600),
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 2.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 0.2.h, color: Color(0xffFAFF00)),
                          color: Color(0xffFEFFCF),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Container(
                          width: 40.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                maxLines: 2,
                                '50% Off',
                                style: body3TextStyle.copyWith(
                                    fontSize: 22, fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Text(
                                'On orders above ₹350',
                                style: body5TextStyle.copyWith(
                                    color: Color(0XffFF4C00),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              ElevatedButton(
                                  onPressed: () {},
                                  style: buttonStyle,
                                  child: Text(
                                    'Activate',
                                    style: body5TextStyle.copyWith(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ))
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
                Text(
                  'Create your own offer'.toUpperCase(),
                  style: body3TextStyle.copyWith(
                    letterSpacing: 0.7,
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 5.w),
                  // padding: EdgeInsets.symmetric(horizontal: 3.w),
                  // decoration: BoxDecoration(
                  //     color: bgColor,
                  //     borderRadius: BorderRadius.circular(10),
                  //     border: Border.all(color: textGrey2, width: 0.2.w)),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: textInputField(
                            'create  coupon code'.toUpperCase(),
                            couponCodeController, (String input) {
                          setState(() {
                            couponCode = input;
                          });
                        }),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: textInputField(
                            'discount percentage'.toUpperCase(),
                            discountController, (String input) {
                          setState(() {
                            discount = input;
                          });
                        }),
                      ),
                      Text(
                        'Or'.toUpperCase(),
                        style: body3TextStyle.copyWith(
                          letterSpacing: 0.7,
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: numberInputField(
                            'flat rs off'.toUpperCase(), flatRsOffController,
                            (String input) {
                          setState(() {
                            flatRsOff = input;
                          });
                        }),
                        // TextField(
                        //   autofocus: false,

                        //   inputFormatters: [
                        //     FilteringTextInputFormatter.digitsOnly,
                        //     LengthLimitingTextInputFormatter(6),
                        //   ],
                        //   keyboardType: TextInputType.number,
                        //   // decoration: InputDecoration(
                        //   //   border: OutlineInputBorder(),
                        //   //   labelText: 'PINCODE'.toUpperCase(),

                        //   //   // hintText: 'Enter Password',
                        //   // ),
                        //   controller: flatRsOffController,
                        //   onChanged: (value) {
                        //     setState(() {
                        //       flatRsOff = value;
                        //     });
                        //   },
                        //   decoration: InputDecoration(
                        //     enabledBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(7),
                        //       borderSide:
                        //           BorderSide(color: textGrey2, width: 0.1.h),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(7),
                        //       borderSide:
                        //           BorderSide(color: textGrey2, width: 0.1.h),
                        //     ),
                        //     contentPadding: EdgeInsets.symmetric(
                        //         horizontal: 5.w, vertical: 2.h),
                        //     labelText: 'flat rs off'.toUpperCase(),
                        //     labelStyle:
                        //         body4TextStyle.copyWith(color: textGrey2),
                        //   ),
                        // ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: numberInputField(
                            'Min. order value'.toUpperCase(),
                            orderValueController, (String input) {
                          setState(() {
                            minOrderValue = input;
                          });
                        }),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: textInputField('Max. discount'.toUpperCase(),
                            maxDiscountController, (String input) {
                          setState(() {
                            maxDiscount = input;
                          });
                        }),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 2.h,
                        ),
                        child: mainButton('create +', textWhite, createOffer),
                      ),
                    ],
                  ),
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
