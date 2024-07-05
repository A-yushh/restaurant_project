import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:sizer/sizer.dart';

class SalesCard extends StatefulWidget {
  final String type;
  const SalesCard({super.key, required this.type});

  @override
  State<SalesCard> createState() => _SalesCardState();
}

class _SalesCardState extends State<SalesCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF5ccefd), Color(0xFF5f3cdd), Color(0xFF6200cd)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sales : ${widget.type}',
            style: h3TextStyle.copyWith(
              color: textWhite,
              fontSize: 20.sp,
            ),
          ),
          Text(
            '₹ 550',
            style: h1TextStyle.copyWith(
              color: const Color(0xffFAFF00),
            ),
          ),
          Text(
            'This week sales : ₹2200',
            style: h6TextStyle.copyWith(color: textWhite),
          )
        ],
      ),
    );
  }
}
