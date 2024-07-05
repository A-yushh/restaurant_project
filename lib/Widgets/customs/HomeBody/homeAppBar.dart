import 'package:flutter/material.dart';
import 'package:restaurant_app/Screens/AccessibilityTab/ads_page.dart';
import 'package:restaurant_app/Screens/AccessibilityTab/complain_page.dart';
import 'package:restaurant_app/Screens/AccessibilityTab/help_center.dart';
import 'package:restaurant_app/Screens/AccessibilityTab/nukkad_manager.dart';
import 'package:restaurant_app/Screens/AccessibilityTab/nukkad_settting.dart';
import 'package:restaurant_app/Screens/AccessibilityTab/payOuts.dart';
import 'package:restaurant_app/Screens/AccessibilityTab/promotions.dart';
import 'package:restaurant_app/Screens/Subscription/getSubscription.dart';
import 'package:sizer/sizer.dart';

import '../../../Screens/notificationScreen.dart';
import '../../constants/colors.dart';
import '../../constants/texts.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  bool isNukkadOpen = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8.h,
      width: 100.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 40.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'NukkadName',
                  style: h5TextStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
                Text(
                  '506 B, kanadiya road main road',
                  style: body5TextStyle.copyWith(
                    fontSize: 9.sp,
                    color: textGrey2,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 25.w,
            height: 4.5.h,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isNukkadOpen = !isNukkadOpen;
                });
              },
              child: Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: isNukkadOpen ? textGrey2 : colorSuccess,
                  ),
                  child: Text(
                    isNukkadOpen ? 'CLOSE' : 'OPEN',
                    style: h5TextStyle.copyWith(
                      color: textWhite,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NotificationScreen(),
                  ),
                );
              },
              child: Icon(
                Icons.notifications_outlined,
                color: textBlack,
                size: 22.sp,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    //Scrolling given for content in Container()
                    return SingleChildScrollView(
                        child: Container(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Container(
                                width: 100.w,
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(20),
                                    topLeft: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Accessibility",
                                      style: body3TextStyle.copyWith(
                                          color: primaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Card.outlined(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: IconButton(
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PromotionsPage()),
                                                    );
                                                  },
                                                  icon: Image.asset(
                                                      'assets/images/Vector.png'),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "Promotions",
                                              style: body6TextStyle,
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Card.outlined(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: IconButton(
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              AdsPage()),
                                                    );
                                                  },
                                                  icon: Image.asset(
                                                      'assets/images/Group.png'),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "Ads",
                                              style: body6TextStyle,
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Card.outlined(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: IconButton(
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ComplaintsWidget()),
                                                    );
                                                  },
                                                  icon: Image.asset(
                                                      'assets/images/iconCarrier.png'),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "Complains",
                                              style: body6TextStyle,
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Card.outlined(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: IconButton(
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HelpCenterWidget()),
                                                    );
                                                  },
                                                  icon: Image.asset(
                                                      'assets/images/iconHelp.png'),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "Help Center",
                                              style: body6TextStyle,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Card.outlined(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: IconButton(
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              GetSubscription()),
                                                    );
                                                  },
                                                  icon: Image.asset(
                                                      'assets/images/persion_add.png'),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Subscription',
                                              style: body6TextStyle,
                                            )
                                            // Text("Subscription")
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Card.outlined(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: IconButton(
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              NukkadManagerWidget()),
                                                    );
                                                  },
                                                  icon: Image.asset(
                                                      'assets/images/persion_manager.png'),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Manager',
                                              style: body6TextStyle,
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Card.outlined(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: IconButton(
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PayOutsWidget()),
                                                    );
                                                  },
                                                  icon: Image.asset(
                                                      'assets/images/payOut.png'),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Payouts',
                                              style: body6TextStyle,
                                            )
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Card.outlined(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: IconButton(
                                                  color: Colors.red,
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              NukkadSettingWidget()),
                                                    );
                                                  },
                                                  icon: Image.asset(
                                                      'assets/images/setting.png'),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              'Setting',
                                              style: body6TextStyle,
                                            )
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ))));
                  });
            },
            child: Icon(
              Icons.menu,
              color: textBlack,
              size: 22.sp,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showCustomDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding: EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Custom Dialog Title',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 16),
              Text('This is a custom dialog with rounded corners.'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
