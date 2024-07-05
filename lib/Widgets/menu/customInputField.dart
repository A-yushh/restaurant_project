import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:sizer/sizer.dart';

class CustomInputField extends StatefulWidget {
  CustomInputField(
      {super.key, required this.labelText, required this.controller});

  final String labelText;
  final TextEditingController controller;

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(7),
      child: TextField(
        controller: widget.controller,
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
          labelText: widget.labelText.toUpperCase(),
          labelStyle: body4TextStyle.copyWith(color: textGrey2),
        ),
      ),
    );
  }
}
