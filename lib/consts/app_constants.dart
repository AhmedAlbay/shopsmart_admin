import 'package:flutter/material.dart';

class AppConstants {
  static const String productImageUrl =
      'https://i.ibb.co/G7nXCW4/3-i-Phone-14.jpg';

  static List<String> categoriesList = [
    'Phones',
    'Clothes',
    'Beauty',
    'Shoes',
    'Funiture',
    'Watches',
  ];
  static List<DropdownMenuItem<String>>? get categoryIsDropDown {
    List<DropdownMenuItem<String>>? menuItem =
        List<DropdownMenuItem<String>>.generate(
      categoriesList.length,
      (index) => DropdownMenuItem(
        value: categoriesList[index],
        child: Text(categoriesList[index]),
      ),
    );
    return menuItem;
  }
}
