import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';

class MenuItemCard extends StatefulWidget {
  @override
  _MenuItemCardState createState() => _MenuItemCardState();
}

class _MenuItemCardState extends State<MenuItemCard> {
  bool inStock = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Veg Manchurian Gravy',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFF0000)),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '[Serving Qty As 1-2 People]',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '₹ 100',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.check_circle,
                  color: Colors.green,
                ),
                Image.network(
                  'https://www.cookingcarnival.com/wp-content/uploads/2021/09/Veg-manchow-soup.webp', // Replace with actual image URL
                  width: 100,
                  height: 100,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 25),
              child: Divider(),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Switch(
                  activeColor: Color(0xFF35BA2A),
                  inactiveThumbColor: Color(0xFFFF0000),
                  inactiveTrackColor: Color(0xFFFFCCCC),
                  value: inStock,
                  onChanged: (value) {
                    setState(() {
                      inStock = value;
                    });
                  },
                ),
                Text(
                  inStock ? 'In stock' : 'Off stock',
                  style: TextStyle(
                      color: inStock ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 50, // Adjust the height as needed
                  width: 1, // Adjust the width as needed
                  color: Color(0xFFD6D6D6),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Color(0xFFFF0000),
                      ),
                      onPressed: () {
                        // Edit action
                      },
                    ),
                    Text(
                      'Edit',
                      style: h6TextStyle,
                    ),
                    SizedBox(
                      width: 10,
                    )
                  ],
                ),
                Container(
                  height: 50, // Adjust the height as needed
                  width: 1, // Adjust the width as needed
                  color: Color(0xFFD6D6D6),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.red,
                  onPressed: () {
                    // Delete action
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
