import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/buttons/addButton.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:restaurant_app/Widgets/menu/addImage.dart';
import 'package:restaurant_app/Widgets/menu/customInputField.dart';
import 'package:sizer/sizer.dart';

class CategoriesForm extends StatefulWidget {
  const CategoriesForm({super.key});

  @override
  State<CategoriesForm> createState() => _CategoriesFormState();
}

class _CategoriesFormState extends State<CategoriesForm> {
  TextEditingController categoryName = TextEditingController();
  String? selectedCategory; // To store the currently selected value

  final List<String> categories = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              CustomInputField(
                  labelText: 'Category Name', controller: categoryName),
              SizedBox(
                height: 20,
              ),
              Material(
                elevation: 1.0,
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(color: textGrey2, width: 0.1.h),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Item',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Icon(Icons.add),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              AddImage(),
              SizedBox(
                height: 20,
              ),
              AddButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
