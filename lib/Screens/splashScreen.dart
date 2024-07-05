import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Screens/onBoardingScreen.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 100.0.h,
            width: 100.0.w,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/splash_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(1000),
              child: Container(
                height: 30.h,
                width: 30.h,
                decoration: BoxDecoration(
                  color: textGrey2,
                  border: Border.all(width: 3.w, color: Colors.white),
                  borderRadius: BorderRadius.circular(1000),
                ),
                // child: Center(
                //   child: Image.asset('assets/images/logo.png'),
                // ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
