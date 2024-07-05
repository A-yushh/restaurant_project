import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../constants/texts.dart';

Widget inviteButton() {
  return ElevatedButton(
    style: ButtonStyle(
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
          side: BorderSide(
            color: primaryColor,
            width: 0.2.h,
          ),
        ),
      ),
    ),
    onPressed: () {},
    child: Text(
      'Invite'.toUpperCase(),
      style: body3TextStyle.copyWith(
          fontWeight: FontWeight.w300, color: primaryColor),
    ),
  );
}
