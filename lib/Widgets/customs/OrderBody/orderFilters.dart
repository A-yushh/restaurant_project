import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:sizer/sizer.dart';

class OrderFilter extends StatefulWidget {
  final bool type;
  final Function(int) selected;
  const OrderFilter({super.key, required this.type, required this.selected});

  @override
  State<OrderFilter> createState() => _OrderFilterState();
}

class _OrderFilterState extends State<OrderFilter> {
  int selectedindex = 0;

  List ongoingOrderFilters = [
    'All',
    'New',
    'Preparing',
    'Ready',
    'On the way',
  ];
  List previousOrderFilters = [
    'All',
    'New',
    'Canceled',
    'Today',
    'Yesterday',
  ];
  @override
  void initState() {
    super.initState();
    selectedindex = 0;
  }

  @override
  Widget build(BuildContext context) {
    bool type = widget.type;
    return SizedBox(
      height: 4.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount:
              type ? ongoingOrderFilters.length : previousOrderFilters.length,
          itemBuilder: (context, index) {
            return Padding(
              key: Key(type
                  ? ongoingOrderFilters[index]
                  : previousOrderFilters[index]),
              padding: EdgeInsets.symmetric(horizontal: 2.w),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedindex = index;
                  });
                  widget.selected(selectedindex);
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 3.w),
                  decoration: BoxDecoration(
                    color: selectedindex == index ? primaryColor : textGrey3,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: primaryColor, width: 0.2.h),
                  ),
                  child: Text(
                    type
                        ? ongoingOrderFilters[index]
                        : previousOrderFilters[index],
                    style: body5TextStyle.copyWith(
                      color: selectedindex == index ? textWhite : textBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
