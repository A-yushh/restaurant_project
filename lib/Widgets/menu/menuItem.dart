import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';

class MenuItem extends StatelessWidget {
  MenuItem({super.key, required this.itemName, required this.screen});
  String itemName;
  Widget screen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => screen));
      },
      child: Container(
        width: double.infinity, // Full width
        padding: const EdgeInsets.all(8.0), // Add some padding if needed
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), // Border radius
          border: Border.all(color: Colors.black), // Black border color
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Space between the widgets
          children: [
            Text(
              itemName,
              style: h5TextStyle,
            ),
            Icon(Icons.add), // "+" icon
          ],
        ),
      ),
    );
  }
}
