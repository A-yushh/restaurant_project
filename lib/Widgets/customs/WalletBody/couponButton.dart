import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../constants/texts.dart';

Widget couponButton() {
  return SizedBox(
    child: Material(
      borderRadius: BorderRadius.circular(10),
      elevation: 2,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryColor,
          border: Border.all(width: 0.2.h, color: primaryColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Copy your code',
              style: h5TextStyle.copyWith(
                color: textWhite,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(width: 2.w),
            Text(
              '58vt3x1',
              style: h5TextStyle.copyWith(fontSize: 14.sp),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.copy_outlined,
                color: textWhite,
                size: 20.sp,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
