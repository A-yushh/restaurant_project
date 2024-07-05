import 'package:flutter/material.dart';
import 'package:restaurant_app/Widgets/customs/MenuBody/menuAppBar.dart';
import 'package:restaurant_app/Widgets/customs/MenuBody/menuItems.dart';
import 'package:restaurant_app/Widgets/customs/MenuBody/menuSearchBar.dart';

class MenuBody extends StatefulWidget {
  const MenuBody({super.key});

  @override
  State<MenuBody> createState() => _MenuBodyState();
}

class _MenuBodyState extends State<MenuBody> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFFF7F7F7),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              MenuAppBar(),
              MenuSearchBar(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: MenuItems(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
