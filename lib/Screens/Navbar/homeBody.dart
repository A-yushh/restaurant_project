import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:restaurant_app/Widgets/customs/HomeBody/analyticsData.dart';
import 'package:restaurant_app/Widgets/customs/HomeBody/salesCard.dart';
import 'package:restaurant_app/Widgets/customs/HomeBody/timeLineFilter.dart';
import 'package:sizer/sizer.dart';

import '../../Widgets/customs/HomeBody/homeAppBar.dart';
import '../../Widgets/customs/HomeBody/salesGraphs.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  String selectedFilter = 'Today';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                child: const HomeAppBar(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(10),
                  child: SalesCard(type: selectedFilter),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 2.h),
                child: Center(
                  child: Text(
                    'Sales Report',
                    style: h2TextStyle.copyWith(color: primaryColor),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: TimeLineFilter(
                  onFilterSelected: (String value) {
                    setState(() {
                      selectedFilter = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: const SalesGraph(),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                child: const AnalyticsData(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
