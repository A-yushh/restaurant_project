import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:restaurant_app/Screens/User/loginScreen.dart';
import 'package:restaurant_app/Screens/otpScreen.dart';
import 'package:restaurant_app/Widgets/buttons/mainButton.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:restaurant_app/Widgets/input_fields/phoneField.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  final String userNumber;
  const ForgotPasswordScreen({Key? key, required this.userNumber})
      : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController ownerPhoneController = TextEditingController();
  String enteredNumber = '';
  bool isLoading = false;

  void routeNext(String userNumber) {
    sendOtp(userNumber);
  }

  Future<void> sendOtp(String userNumber) async {
    setState(() {
      isLoading = true;
    });
    try {
      var baseUrl = dotenv.env['BASE_URL'];
      String requestBody = jsonEncode({
        "to": "+1234567890",
        "body": enteredNumber,
      });
      // print(reqData);
      final response = await http.post(Uri.parse('$baseUrl/sms/sendSMS'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: requestBody);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData != null && responseData['executed']) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: colorSuccess,
              content: Text("Otp Send Successfully")));
          setState(() {
            isLoading = false;
          });
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // // Remove the data associated with the key 'user_info'
          // await prefs.remove('user_info');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OTPScreen(
                userNumber: userNumber,
                option: 1,
              ),
            ),
          );
        } else {
          // RegistrationCompleteScreen
          setState(() {
            isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: colorFailure,
                content: Text(responseData['message'])),
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });
        // return "Failed to Update profile";
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: colorFailure,
            content: Text("Failed to send Otp")));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: colorFailure, content: Text("Error: Server Error")));
    }
  }

  @override
  Widget build(BuildContext context) {
    String userNumber = widget.userNumber;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 19.sp,
            color: Colors.black,
          ),
        ),
        title: Text('Forgot Password', style: h4TextStyle),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 5.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Verify your phone number ${'XXXXXXX${userNumber.substring(userNumber.length - 3)}'} linked to your account and enter otp to recover your account.',
                style: body4TextStyle,
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h, bottom: 8.h),
                child: PhoneField(
                  controller: ownerPhoneController,
                  onPhoneNumberChanged: (String number) {
                    setState(() {
                      enteredNumber = number;
                    });
                  },
                ),
                //  phoneField((String number) {
                //   setState(() {
                //     enteredNumber = number;
                //   });
                // }),
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : mainButton(
                      'Send OTP',
                      textWhite,
                      () => routeNext(enteredNumber),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
