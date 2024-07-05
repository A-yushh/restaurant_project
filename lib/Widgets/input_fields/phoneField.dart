import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:sizer/sizer.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneField extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onPhoneNumberChanged;

  PhoneField({required this.controller, required this.onPhoneNumberChanged});

  @override
  _PhoneFieldState createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  TextEditingController _controller = TextEditingController();
  Color _textColor = textGrey2; // Initial text color

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateTextColor);
  }

  void _updateTextColor() {
    setState(() {
      if (_controller.text.length == 10) {
        _textColor = Colors.green;
      } else {
        _textColor = textGrey2;
      }
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_updateTextColor);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3.0,
      borderRadius: BorderRadius.circular(7.0),
      child: IntlPhoneField(
        controller: _controller,
        disableLengthCheck: true,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(10),
        ],
        keyboardType: TextInputType.phone,
        showDropdownIcon: false,
        flagsButtonPadding: EdgeInsets.symmetric(horizontal: 3.w),
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.0),
        ),
        decoration: InputDecoration(
          labelText: 'Mobile'.toString().toUpperCase(),
          labelStyle: body4TextStyle.copyWith(color: _textColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide(color: textGrey2, width: 0.1.h),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide(color: textGrey2, width: 0.1.h),
          ),
        ),
        style: TextStyle(color: _textColor),
        dropdownTextStyle: TextStyle(
          color: textBlack,
          fontFamily: 'Poppins',
          fontSize: 13.sp,
        ),
        initialCountryCode: 'IN',
        onChanged: (phone) {
          widget.onPhoneNumberChanged(phone.completeNumber);
        },
      ),
    );
  }
}
