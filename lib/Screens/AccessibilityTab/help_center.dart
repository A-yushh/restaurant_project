import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Screens/AccessibilityTab/chat_screen.dart';
import 'package:restaurant_app/Widgets/buttons/mainButton.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:sizer/sizer.dart';

class HelpCenterWidget extends StatefulWidget {
  const HelpCenterWidget({super.key});

  @override
  State<HelpCenterWidget> createState() => _HelpCenterWidgetState();
}

class _HelpCenterWidgetState extends State<HelpCenterWidget> {
  // bool _isExpanded = false;
  List<bool> _isExpandedList = [];
  List<Map<String, dynamic>> dataList = [
    {'id': 1, 'title': 'Title 1', 'subtitle': 'Subtitle 1'},
    {'id': 2, 'title': 'Title 2', 'subtitle': 'Subtitle 2'},
    {'id': 3, 'title': 'Title 3', 'subtitle': 'Subtitle 3'},
    {'id': 4, 'title': 'Title 4', 'subtitle': 'Subtitle 4'},
    {'id': 5, 'title': 'Title 5', 'subtitle': 'Subtitle 5'},
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isExpandedList = List<bool>.generate(dataList.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Cenre', style: h4TextStyle),
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 2.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: dataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: textGrey2),
                        borderRadius: BorderRadius.circular(10.0),
                        color:
                            textGray4, // Change this color as per your requirement
                      ),
                      margin: EdgeInsets.symmetric(vertical: 2.w),
                      child: ListTile(
                        title: Text(dataList[index]['title']),
                        subtitle: _isExpandedList[index]
                            ? Text(dataList[index]['subtitle'])
                            : null,
                        trailing: IconButton(
                          icon: Icon(
                            _isExpandedList[index]
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            size: 19.sp,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _isExpandedList[index] = !_isExpandedList[index];
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Still need help?'.toUpperCase(),
                    style: body6TextStyle.copyWith(
                      letterSpacing: 0.7,
                      fontSize: 15,
                      color: primaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 2.h,
                  ),
                  child: mainButton(
                      'chat with us'.toUpperCase(), textWhite, routerChat),
                ),
                // Align(
                //   alignment: Alignment.center,
                //   child: Text(
                //     'Still need help?'.toUpperCase(),
                //     style: body6TextStyle.copyWith(
                //       letterSpacing: 0.7,
                //       fontSize: 15,
                //       color: primaryColor,
                //       fontWeight: FontWeight.w400,
                //     ),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void routerChat() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ChatScreenWidget(),
      ),
    );
  }
}
