import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../../constants/texts.dart';

Widget referalNotification() {
  return SizedBox(
    height: 20.h,
    width: 100.w,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('assets/images/referal.png'),
        SizedBox(
          width: 50.w,
          child: Text(
            'Refer a friend  to Nukkad foods and you both earn ₹50 when they place their first order! ',
            style: body4TextStyle.copyWith(fontSize: 11.sp),
            textAlign: TextAlign.start,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    ),
  );
}
