import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:sizer/sizer.dart';

class RegistrationTimeline extends StatefulWidget {
  final int pageIndex;

  const RegistrationTimeline({Key? key, required this.pageIndex})
      : super(key: key);

  @override
  State<RegistrationTimeline> createState() => _RegistrationTimelineState();
}

class _RegistrationTimelineState extends State<RegistrationTimeline> {
  int page = 0;
  int counter = 4;
  List list = [0, 1, 2, 3];

  List<String> stageTexts = [
    'Nukkad Information',
    'Owner details',
    'Nukkad Information',
    'Documentation',
  ];

  List filename = [
    'one_icon.svg',
    'two_icon.svg',
    'three_icon.svg',
    'four_icon.svg',
  ];
  @override
  void initState() {
    super.initState();
    page = widget.pageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      height: 10.h,
      child: Padding(
        padding: EdgeInsets.only(right: 3.w, left: 3.w, top: 2.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStepItem(0),
            _buildStepItem(1),
            _buildStepItem(2),
            _buildStepItem(3),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem(int index) {
    bool isCompleted = index <= page;
    return SizedBox(
      width: 20.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 3.5.h,
            width: 3.5.h,
            padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 1.w),
            decoration: BoxDecoration(
              color: isCompleted ? primaryColor : textWhite,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: isCompleted ? primaryColor : textGrey2,
                width: 0.3.h,
              ),
            ),
            child: SvgPicture.asset(
              'assets/icons/${filename[index]}',
              color: isCompleted ? textWhite : textGrey2,
              fit: BoxFit.fill,
            ),
          ),
          Text(
            stageTexts[index],
            style: body5TextStyle.copyWith(
              fontSize: 9.sp,
              fontWeight: FontWeight.w200,
              color: textBlack,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
