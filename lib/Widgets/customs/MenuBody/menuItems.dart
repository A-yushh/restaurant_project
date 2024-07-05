import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:restaurant_app/Widgets/menu/menuItemCard.dart';

class MenuItems extends StatefulWidget {
  const MenuItems({Key? key}) : super(key: key);

  @override
  _MenuItemsState createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> with TickerProviderStateMixin {
  bool isExpanded = false;

  void _toggleExpand() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _toggleExpand,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Main Course (10)',
                  style: h6TextStyle,
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  size: 30,
                ),
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: CurvedAnimation(
              parent: AnimationController(
                vsync: this,
                duration: Duration(milliseconds: 300),
              )..forward(),
              curve: Curves.easeInOut,
            ),
            axisAlignment: 0.0,
            child: isExpanded
                ? Column(
                    children: [
                      MenuItemCard(),
                      MenuItemCard(),
                      MenuItemCard(),
                      MenuItemCard(),
                    ],
                  )
                : SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
