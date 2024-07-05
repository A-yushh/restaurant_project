import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:sizer/sizer.dart';

import '../../Widgets/constants/texts.dart';
import '../../Widgets/customs/WalletBody/earningWidget.dart';

class viewEarningScreen extends StatefulWidget {
  const viewEarningScreen({super.key});

  @override
  State<viewEarningScreen> createState() => _viewEarningScreenState();
}

class _viewEarningScreenState extends State<viewEarningScreen> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Earnings', style: h4TextStyle),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 19.sp,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 3.h),
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(10),
                child: GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.w),
                    decoration: BoxDecoration(
                      color: textBlack,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: textWhite,
                          size: 25.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          selectedDate != null
                              ? DateFormat('E, dd/MM/yyyy')
                                  .format(selectedDate!)
                              : 'Select Date',
                          style: body3TextStyle.copyWith(color: textWhite),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 3.h),
              decoration: BoxDecoration(
                color: textWhite,
                border: Border.all(color: textGrey2, width: 0.2.h),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return earningsWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
}
