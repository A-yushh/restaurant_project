import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:restaurant_app/Screens/Subscription/getSubscription.dart';
import 'package:restaurant_app/Screens/User/getStartedScreen.dart';
import 'package:restaurant_app/Widgets/buttons/forgotPasswordButton.dart';
import 'package:restaurant_app/Widgets/buttons/mainButton.dart';
import 'package:restaurant_app/Widgets/buttons/socialLoginButtons.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:restaurant_app/Widgets/customs/HomeBody/viewTotalBill.dart';
import 'package:restaurant_app/Widgets/input_fields/passwordField.dart';
import 'package:restaurant_app/Widgets/input_fields/phoneField.dart';
import 'package:restaurant_app/homeScreen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController ownerPhoneController = TextEditingController();
  String userNumber = '';
  String userPassword = '';
  bool isLoading = false;

  void routeHome() {
    if (userNumber != '' && userPassword != '') {
      // userNumber = userNumber.substring(3);
      if (userNumber.substring(3).length == 10) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        // ViewTotalBillWidget
        // signIn();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: colorFailure,
            content: Text("Please Enter Phone Number Correctly")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: colorFailure,
            content: Text("Please Fill Both Field")),
      );
    }
  }

  Future<void> signIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      var baseUrl = dotenv.env['BASE_URL'];
      var reqData = {'phonenumber': userNumber, 'password': userPassword};
      String requestBody = jsonEncode(reqData);
      final response = await http.post(Uri.parse('$baseUrl/auth/login'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: requestBody);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData != null && responseData['executed']) {
          saveUserInfo(responseData['uid']);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: colorFailure,
              content: Text("Login Successfully")));
          setState(() {
            isLoading = false;
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
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

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: colorFailure, content: Text("Failed to login")));
        // throw Exception('Failed to login');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: colorFailure, content: Text("Error: Server Error")));
      // print('Error: $e');
      // Handle error
    }
  }

  Future<void> saveUserInfo(userInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('User_id', userInfo);
    print('sdggdgsagasssdasdasdasdads');
    print(prefs.getString('User_id'));
  }

  void routeRegister() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const GetStartedScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sign In', style: h1TextStyle),
                Padding(
                  padding: EdgeInsets.only(top: 6.h, bottom: 4.h),
                  child: PhoneField(
                    controller: ownerPhoneController,
                    onPhoneNumberChanged: (String number) {
                      setState(() {
                        userNumber = number;
                      });
                    },
                  ),
                ),
                PasswordField(
                  labelText: 'Password',
                  onValueChanged: (String password) {
                    setState(() {
                      userPassword = password;
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: forgotPassButton(userNumber, context),
                ),
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: mainButton('Sign In', textWhite, routeHome),
                      ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.only(top: 6.h, bottom: 2.h),
                    child: Text(
                      'Have not listed with us yet?',
                      style: body4TextStyle.copyWith(
                          fontSize: 15.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: mainButton('Register Now!', textWhite, routeRegister),
                ),
                SizedBox(height: 3.h),
                Center(
                  child: Text(
                    'Sign in with',
                    style: body4TextStyle.copyWith(color: textGrey2),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 2.h, bottom: 3.h),
                    height: 12.h,
                    width: 50.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        socialLoginButton('google.png', onGoogleTap),
                        socialLoginButton('facebook.png', onFacebookTap),
                        socialLoginButton('twitter.png', onTwitterTap),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

onGoogleTap() {}

onFacebookTap() {}

onTwitterTap() {}
