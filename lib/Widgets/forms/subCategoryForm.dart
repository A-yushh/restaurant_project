import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/buttons/addButton.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:restaurant_app/Widgets/menu/customInputField.dart';
import 'package:sizer/sizer.dart';

class SubCategoriesForm extends StatefulWidget {
  const SubCategoriesForm({super.key});

  @override
  State<SubCategoriesForm> createState() => _SubCategoriesFormState();
}

class _SubCategoriesFormState extends State<SubCategoriesForm> {
  TextEditingController subCategoryName = TextEditingController();
  String? selectedCategory; // To store the currently selected value

  final List<String> categories = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Sub-category'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              CustomInputField(
                  labelText: 'Sub-Category Name', controller: subCategoryName),
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
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFFCACACA))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Category',
                      style: h5TextStyle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Define the category of the item',
                      style: TextStyle(color: Color(0xFFCACACA)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey, // Choose your border color
                                width: 1.0, // Choose your border width
                              ),
                              borderRadius: BorderRadius.circular(
                                  8.0), // Optional: for rounded corners
                            ),
                            child: DropdownButton<String>(
                              elevation: 3,
                              value: selectedCategory,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Choose item category'),
                              ),
                              isExpanded:
                                  true, // Ensure the dropdown button fills the full width
                              underline:
                                  Container(), // Remove the default underline
                              items: categories.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(item),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedCategory = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
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
