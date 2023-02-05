import 'package:flutter/material.dart';
import 'package:rentalapp/Screens/account_screen.dart';
import 'package:rentalapp/Screens/home_screen.dart';
import 'package:rentalapp/Screens/menu_screen.dart';

const double kAppBarHeight = 80;

const String userName = 'Person1';

const String userImage = "assets/images/userinfo/person1.png";

const String userMailid = 'abcdef@gmail.com';

const String userContactno = '9876543210';

const List<Widget> screens = [
  HomeScreen(),
  AccountScreen(),
  MenuScreen(),
];

const List<String> categoriesList = ["Non-Veg", "Veg", "Snacks", "Cakes"];

const List<String> categoryLogos = [
  "assets/images/horizontallisticons/Apartmenticon.png",
  "assets/images/horizontallisticons/houseicon.png",
  "assets/images/horizontallisticons/hostelicon.png",
  "assets/images/horizontallisticons/PGicon.png",
];

const List<String> menuCategoryLists = [
  "SELL",
  "Settings",
  "Help Center",
  "Exit",
];

const List<String> menuCategoryLogos = [
  "assets/images/userinfo/seller.png",
  "assets/images/menucatagorylogos/settings2icon.png",
  "assets/images/menucatagorylogos/helpicon.png",
  "assets/images/menucatagorylogos/exitappicon.png",
];
List<String> keysOfRating = [
  "Very bad",
  "Poor",
  "Average",
  "Good",
  "Excellent"
];
