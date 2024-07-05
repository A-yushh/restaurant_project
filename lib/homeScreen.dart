import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant_app/Screens/AccessibilityTab/complain_page.dart';
import 'package:restaurant_app/Screens/Subscription/subscribe_card.dart';
import 'package:restaurant_app/Widgets/buttons/mainButton.dart';
import 'package:sizer/sizer.dart';
import 'Screens/Navbar/MenuBody.dart';
import 'Screens/Navbar/homeBody.dart';
import 'Screens/Navbar/orderBody.dart';
import 'Screens/Navbar/walletBody.dart';

import 'Widgets/constants/colors.dart';
import 'Widgets/constants/texts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeBody(),
    const MenuBody(),
    const OrderBody(),
    const WalletBody(),
    const ComplaintsWidget(),
  ];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _showBottomSheet();
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the bottom sheet to be scrollable
      builder: (BuildContext context) {
        return Container(
          height: 90.h,
          // padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 2.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: textWhite,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SubscribeCard(),
                Padding(
                  padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 2.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 100.w,
                        padding: EdgeInsets.symmetric(
                            horizontal: 3.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.2.h, color: primaryColor),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Image.asset('assets/images/subscribe.png'),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Subscribe to Nukkad foods',
                              style: body3TextStyle.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 2.h),
                            Container(
                              width: 60.w,
                              child: Column(
                                children: [
                                  _buildRow('2x New customers'),
                                  SizedBox(height: 2.h),
                                  _buildRow('3x Repeat customers'),
                                  SizedBox(height: 2.h),
                                  _buildRow('More Orders'),
                                  SizedBox(height: 2.h),
                                  _buildRow('More Earnings'),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2.h),
                        child: mainButton(
                            'Subscribe at just ₹ 399', textWhite, routeHome),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(top: 1.h, bottom: 2.h),
                          child: Text(
                            'For 4 Month',
                            style: body4TextStyle.copyWith(
                                color: primaryColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: body4TextStyle.copyWith(color: primaryColor),
        unselectedLabelStyle: body4TextStyle.copyWith(color: textGrey2),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home_icon.svg',
              color: _selectedIndex == 0 ? primaryColor : textGrey2,
              height: 3.5.h,
              width: 3.5.h,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/menu_icon.svg',
              color: _selectedIndex == 1 ? primaryColor : textGrey2,
              height: 3.5.h,
              width: 3.5.h,
            ),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/order_icon.svg',
              color: _selectedIndex == 2 ? primaryColor : textGrey2,
              height: 3.5.h,
              width: 3.5.h,
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/wallet_icon.svg',
              color: _selectedIndex == 3 ? primaryColor : textGrey2,
              height: 3.5.h,
              width: 3.5.h,
            ),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/iconCarrier.png',
              scale: 1.0,
              color: _selectedIndex == 4 ? primaryColor : textGrey2,
              height: 3.5.h,
              width: 3.5.h,
            ),
            label: 'Complains',
          ),
        ],
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        selectedItemColor: primaryColor,
        unselectedItemColor: textGrey2,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildRow(String text) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.check_circle_rounded,
          color: Colors.black,
        ),
        SizedBox(width: 2.h),
        Text(
          text,
          style: body4TextStyle.copyWith(
              color: Colors.black, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
      ],
    );
  }

  routeHome() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: colorFailure,
        content: Text("Phone Pay Integration Pending")));
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const RenewSubscription(),
    //   ),
    // );
  }
}
