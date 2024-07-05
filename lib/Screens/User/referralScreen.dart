import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/Controller/Profile/profile_controller.dart';
import 'package:restaurant_app/Screens/User/registerScreen.dart';
import 'package:restaurant_app/Widgets/buttons/mainButton.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:restaurant_app/Widgets/input_fields/textInputField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({Key? key}) : super(key: key);

  @override
  State<ReferralScreen> createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  int? _selectedOption;
  LocalController _getSavedData = LocalController();
  String executiveId = '';
  String executiveName = '';
  late Map<String, dynamic> userInfo;
  final executiveIdController = TextEditingController();
  final executiveNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    try {
      Map<String, dynamic>? getData = await _getSavedData.getUserInfo();
      setState(() {
        userInfo = getData!;
        // isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      // Handle error
    }
  }

  routeRegistration() {
    if (_selectedOption != null) {
      String addData;
      if (_selectedOption == 0) {
        userInfo['referred'] = 'Nukkad Foods Executive';
        saveUserInfo(userInfo);
      } else if (_selectedOption == 1) {
        userInfo['referred'] = 'A Friend';
        saveUserInfo(userInfo);
      } else {
        userInfo['referred'] = 'Self Registration';
        saveUserInfo(userInfo);
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RegistrationScreen()),
      );
      // Encode the updated Map as a JSON string
      // String updatedUserInfoString = jsonEncode(userInfo);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: colorFailure,
          content: Text("Please select a field")));
    }
  }

  Future<void> saveUserInfo(Map<String, dynamic> userInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_info', jsonEncode(userInfo));
    print(prefs.getString('user_info'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 8.h, left: 5.w, right: 5.w),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Who recommended nukkad foods to you?'.toUpperCase(),
                style: body3TextStyle,
                maxLines: 2,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h),
            child: Column(
              children: [
                buildRadioButton(0, "Nukkad Foods Executive"),
                Padding(
                  padding: EdgeInsets.only(
                      top: 2.h, right: 5.w, left: 5.w, bottom: 2.h),
                  child: textInputField('Executive ID', executiveIdController,
                      (String id) {
                    setState(() {
                      executiveId = id;
                    });
                  }),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 2.h, right: 5.w, left: 5.w, bottom: 2.h),
                  child: textInputField(
                      'Executive Name', executiveNameController, (String name) {
                    setState(() {
                      executiveName = name;
                    });
                  }),
                ),
                buildRadioButton(1, "A Friend"),
                buildRadioButton(2, "Self Registration"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 5.w, left: 5.w, top: 2.h),
            child: mainButton('NEXT', textWhite, () => routeRegistration()),
          ),
        ],
      ),
    );
  }

  Widget buildRadioButton(int value, String title) {
    return RadioListTile<int>(
      value: value,
      groupValue: _selectedOption,
      onChanged: (newValue) {
        setState(() {
          _selectedOption = newValue;
        });
      },
      toggleable: true,
      title: Text(
        title,
        style: body3TextStyle.copyWith(fontWeight: FontWeight.w600),
      ),
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: primaryColor,
    );
  }
}
