import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:restaurant_app/Screens/User/loginScreen.dart';
import 'package:restaurant_app/Widgets/buttons/mainButton.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:sizer/sizer.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<OnBoardingScreenState>();
  int currentPageIndex = 0;

  void _onPageChange(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  Widget _buildImage(String assetName) {
    return Padding(
      padding: EdgeInsets.only(top: 9.h),
      child: Image.asset(
        'assets/images/introduction/$assetName',
        width: 98.w,
      ),
    );
  }

  routeLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      titleTextStyle: h3TextStyle.copyWith(color: primaryColor),
      bodyTextStyle: body2TextStyle,
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: 3000,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16, right: 16),
            child: currentPageIndex != 2
                ? TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateColor.resolveWith(
                        (states) => Colors.transparent,
                      ),
                    ),
                    onPressed: () => routeLogin(),
                    child: Text(
                      'Skip',
                      style: h5TextStyle.copyWith(color: textGrey2),
                    ),
                  )
                : null,
          ),
        ),
      ),
      globalFooter: currentPageIndex == 2
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
              child: mainButton('Next', textWhite, routeLogin),
            )
          : SizedBox(
              height: 15.2.h,
            ),
      pages: [
        PageViewModel(
          title: "List Your Stall",
          body: "List you stall/ food truck/ Restaurant on nukkad foods.",
          image: _buildImage('page_1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Accept Orders",
          body: "Fix your menu, and accept orders from customers ",
          image: _buildImage('page_2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Relax!",
          body:
              "Prepare order and hand over to the delivery partner to deliver deliciousness.",
          image: _buildImage('page_3.png'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () {},
      onSkip: () {},
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      showDoneButton: false,
      showNextButton: false,
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: const EdgeInsets.all(12.0),
      dotsDecorator: DotsDecorator(
        size: Size(1.5.h, 1.2.h),
        color: textGrey2,
        activeSize: Size(1.5.h, 1.5.h),
        activeColor: primaryColor,
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      onChange: _onPageChange,
    );
  }
}
