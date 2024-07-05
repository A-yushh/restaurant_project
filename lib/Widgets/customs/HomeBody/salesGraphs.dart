import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:sizer/sizer.dart';

class SalesGraph extends StatefulWidget {
  const SalesGraph({super.key});

  @override
  State<SalesGraph> createState() => _SalesGraphState();
}

class _SalesGraphState extends State<SalesGraph> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: const Color(0xFFfeefe8),
        border: Border.all(color: textGrey3, width: 0.2.h),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          'Graphs coming soon...',
          style: h4TextStyle.copyWith(color: textGrey1),
        ),
      ),
    );
  }
}
