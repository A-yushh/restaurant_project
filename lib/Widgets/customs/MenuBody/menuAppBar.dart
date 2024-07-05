import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/menu/addItems.dart';
import 'package:sizer/sizer.dart';

import '../../constants/colors.dart';
import '../../constants/texts.dart';

class MenuAppBar extends StatefulWidget {
  const MenuAppBar({Key? key}) : super(key: key);

  @override
  State<MenuAppBar> createState() => _MenuAppBarState();
}

class _MenuAppBarState extends State<MenuAppBar> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Menu',
                  style: h3TextStyle,
                ),
                InkWell(
                  onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(5.0)),
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: AddItems(),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(5.0)),
              ),
              isScrollControlled: true,
            );
          },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.3.h),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Add +',
                      style: h4TextStyle.copyWith(color: textWhite),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 25.w,
                  height: 25.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1000),
                    border: Border.all(width: 0.5.h, color: primaryColor),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/restaurant.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shiva Chinese Wok',
                        style: h4TextStyle.copyWith(color: primaryColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        'Tilak Nagar, Indore',
                        style: body4TextStyle.copyWith(fontSize: 13.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        'Chinese, Momos',
                        style: body5TextStyle.copyWith(color: textGrey3),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
