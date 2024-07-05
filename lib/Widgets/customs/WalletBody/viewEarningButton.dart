import 'package:flutter/material.dart';
import 'package:restaurant_app/Screens/Wallet/viewEarningsScreen.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../constants/texts.dart';

Widget viewEarningButton(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const viewEarningScreen(),
        ),
      );
    },
    child: SizedBox(
      child: Material(
        borderRadius: BorderRadius.circular(10),
        elevation: 2,
        child: Container(
          width: 67.w,
          padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Text(
                'View Earnings'.toUpperCase(),
                style: h5TextStyle.copyWith(color: textWhite),
              ),
              SizedBox(width: 2.w),
              Icon(
                Icons.arrow_right_alt_rounded,
                color: textWhite,
                size: 25.sp,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
