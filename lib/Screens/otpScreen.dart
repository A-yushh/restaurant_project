import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:restaurant_app/Screens/Password/resetPasswordScreen.dart';
import 'package:restaurant_app/Screens/User/ownerDetailsScreen.dart';
import 'package:restaurant_app/Widgets/buttons/mainButton.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:sizer/sizer.dart';

class OTPScreen extends StatefulWidget {
  final String userNumber;
  final int option;
  const OTPScreen({super.key, required this.userNumber, required this.option});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String enteredpin = '';

  @override
  Widget build(BuildContext context) {
    String userNumber = widget.userNumber;
    int option = widget.option;

    void chooseRoute() {
      if (option == 1) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ResetPasswordScreen(),
          ),
        );
      } else if (option == 2) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const OwnerDetailsScreen(),
          ),
        );
      }
    }

    void routeBack() {
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Verification', style: h4TextStyle),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => routeBack(),
          icon: Icon(
            Icons.arrow_back_ios,
            size: 19.sp,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text('Verify with OTP sent to $userNumber', style: h3TextStyle),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: OtpTextField(
                  fieldHeight: 8.h,
                  fieldWidth: 15.w,
                  numberOfFields: 4,
                  borderColor: Colors.grey.shade600,
                  focusedBorderColor: Colors.black,
                  cursorColor: Colors.black,
                  borderRadius: BorderRadius.circular(7),
                  showFieldAsBox: true,
                  clearText: true,
                  onSubmit: (String verificationCode) {
                    enteredpin = verificationCode;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 2.h),
                child: mainButton(
                  'Continue',
                  textWhite,
                  () => chooseRoute(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive OTP?",
                    style: body4TextStyle,
                  ),
                  TextButton(
                    onPressed: () => routeBack(),
                    child: Text(
                      'Resend',
                      style: body4TextStyle.copyWith(color: primaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
