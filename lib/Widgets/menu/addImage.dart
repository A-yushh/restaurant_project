import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';

class AddImage extends StatelessWidget {
  const AddImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFCACACA))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Image (optional)',
            style: h5TextStyle,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: DottedBorder(
              strokeWidth: 2,
              dashPattern: [6, 3],
              borderType: BorderType.RRect,
              radius: Radius.circular(10),
              color: Color(0xFFB8B8B8),
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  // border: Border.all(color: Color(0xFFB8B8B8)),
                ),
                child: Center(
                  child: Icon(
                    Icons.add,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
