import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/buttons/addButton.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:restaurant_app/Widgets/menu/addImage.dart';
import 'package:restaurant_app/Widgets/menu/categories.dart';
import 'package:restaurant_app/Widgets/menu/customInputField.dart';

class DishesForm extends StatefulWidget {
  const DishesForm({super.key});

  @override
  State<DishesForm> createState() => _DishesFormState();
}

class _DishesFormState extends State<DishesForm> {
  TextEditingController itemName = TextEditingController();
  TextEditingController basePrice = TextEditingController();
  TextEditingController packingCharges = TextEditingController();
  TextEditingController noOfServers = TextEditingController();

  String? selectedCategory;
  final List<String> categories = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
  String selectedLabel = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Dishes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Category(
                      imagePath: 'assets/images/veg.jpeg',
                      label: 'Veg',
                      isSelected: selectedLabel == 'Veg',
                      onTap: () => setState(() => selectedLabel = 'Veg'),
                    ),
                    SizedBox(width: 10),
                    Category(
                      imagePath: 'assets/images/nonveg.jpeg',
                      label: 'Non-Veg',
                      isSelected: selectedLabel == 'Non-Veg',
                      onTap: () => setState(() => selectedLabel = 'Non-Veg'),
                    ),
                    SizedBox(width: 10),
                    Category(
                      imagePath: 'assets/images/vegan.png',
                      label: 'Vegan',
                      isSelected: selectedLabel == 'Vegan',
                      onTap: () => setState(() => selectedLabel = 'Vegan'),
                    ),
                    SizedBox(width: 10),
                    Category(
                      imagePath: 'assets/images/glutenfree.png',
                      label: 'Gluten-Free',
                      isSelected: selectedLabel == 'Gluten-Free',
                      onTap: () =>
                          setState(() => selectedLabel = 'Gluten-Free'),
                    ),
                    SizedBox(width: 10),
                    Category(
                      imagePath: 'assets/images/dairyfree.png',
                      label: 'Dairy Free',
                      isSelected: selectedLabel == 'Dairy Free',
                      onTap: () => setState(() => selectedLabel = 'Dairy Free'),
                    ),
                    SizedBox(width: 10),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CustomInputField(labelText: 'Item Name', controller: itemName),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFCACACA)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Item Price', style: h5TextStyle),
                    SizedBox(height: 20),
                    Text(
                      'Enter the price details of the item',
                      style: TextStyle(color: Color(0xFFCACACA)),
                    ),
                    SizedBox(height: 20),
                    CustomInputField(
                        labelText: 'Base Price', controller: basePrice),
                    SizedBox(height: 20),
                    CustomInputField(
                        labelText: 'Packing Charges',
                        controller: packingCharges),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFCACACA)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Serving Information', style: h5TextStyle),
                    SizedBox(height: 20),
                    Text(
                      'Enter the size and quantity of the item',
                      style: TextStyle(color: Color(0xFFCACACA)),
                    ),
                    SizedBox(height: 20),
                    CustomInputField(
                        labelText: 'No of Serves', controller: noOfServers),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Color(0xFFCACACA)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Category', style: h5TextStyle),
                    SizedBox(height: 20),
                    Text(
                      'Define the category of the item',
                      style: TextStyle(color: Color(0xFFCACACA)),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.grey, width: 1.0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: DropdownButton<String>(
                              elevation: 3,
                              value: selectedCategory,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Choose item category'),
                              ),
                              isExpanded: true,
                              underline: Container(),
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
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              AddImage(),
              SizedBox(height: 20),
              AddButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
