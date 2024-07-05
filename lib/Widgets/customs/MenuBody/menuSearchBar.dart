import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../constants/texts.dart';

class MenuSearchBar extends StatefulWidget {
  const MenuSearchBar({super.key});

  @override
  State<MenuSearchBar> createState() => _MenuSearchBarState();
}

class _MenuSearchBarState extends State<MenuSearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFf7f7f7),
      padding: EdgeInsets.fromLTRB(2.w, 0, 2.w, 2.h),
      child: Container(
        margin: EdgeInsets.fromLTRB(2.w, 2.h, 2.w, 0),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search items or categories',
            contentPadding: EdgeInsets.symmetric(vertical: 1.h),
            hintStyle: body4TextStyle.copyWith(color: Color(0xFF7E7E7E)),
            prefixIcon: IconButton(
              onPressed: () {
                print('Search button pressed');
              },
              icon: SvgPicture.asset(
                'assets/icons/search_icon.svg',
                color: textGrey2,
                height: 3.h,
              ),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                print('Microphone button pressed');
              },
              icon: SvgPicture.asset('assets/icons/microphone_icon.svg',
                  color: primaryColor, height: 3.h),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: textGrey2, width: 0.2.h),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: textGrey2, width: 0.2.h),
            ),
          ),
        ),
      ),
    );
  }
}
