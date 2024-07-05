import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:restaurant_app/Widgets/customs/WalletBody/viewEarningButton.dart';
import 'package:sizer/sizer.dart';

import '../../Widgets/customs/WalletBody/couponButton.dart';
import '../../Widgets/customs/WalletBody/inviteButton.dart';
import '../../Widgets/customs/WalletBody/referalMap.dart';
import '../../Widgets/customs/WalletBody/referalNotification.dart';
import '../../Widgets/customs/WalletBody/walletWidget.dart';

class WalletBody extends StatefulWidget {
  const WalletBody({super.key});

  @override
  State<WalletBody> createState() => _WalletBodyState();
}

class _WalletBodyState extends State<WalletBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Wallet',
                style: h1TextStyle,
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                child: const WalletWidget(),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 3.h),
                child: viewEarningButton(context),
              ),
              Text('Refer and Earn program', style: h4TextStyle),
              referalNotification(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
                child: couponButton(),
              ),
              inviteButton(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 2.w),
                child: SizedBox(
                  width: 100.w,
                  child: Text(
                    'How do refer and earn work?'.toUpperCase(),
                    style: body3TextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              referalMap()
            ],
          ),
        ),
      ),
    );
  }
}
