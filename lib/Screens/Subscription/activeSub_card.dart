import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:sizer/sizer.dart';

// import '../../../constants/texts.dart';

class ActiveSubscribeCard extends StatefulWidget {
  const ActiveSubscribeCard({super.key});

  @override
  State<ActiveSubscribeCard> createState() => _ActiveSubscribeCardState();
}

class _ActiveSubscribeCardState extends State<ActiveSubscribeCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100.w,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xff5dcafc),
                Color(0xff5e5be3),
                Color(0xff6200cd),
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40.0),
            child: Column(
              children: [
                Text(
                  'Your Subscription!',
                  style: body1TextStyle.copyWith(
                      color: textWhite, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Subscribe to nukkad foods to satrt recieving orders',
                  style: body5TextStyle.copyWith(
                      color: textWhite, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
