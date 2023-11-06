import 'package:flutter/material.dart';

class GlobalVariables {
  // COLORS
  static const gradient = LinearGradient(
    colors: [
      Color(0xff9746ff),
      Color.fromARGB(255, 128, 39, 176),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [0.5, 1.0],
  );

  static const primaryColor = Color(0xff9746ff);
  static const primaryLightColor = Color(0xffe1d4ff);
  static const secondaryColor = Color.fromRGBO(255, 153, 0, 1);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = const Color(0xff9746ff);
  static const unselectedNavBarColor = Colors.black87;
  static const blackColor = Colors.black87;

  static const List<String> carouselImages = [
    'https://t4.ftcdn.net/jpg/02/24/88/07/240_F_224880717_YmNbocwrjak9AyvQ9QrTnELWCeOGtKvH.jpg',
    'https://t3.ftcdn.net/jpg/06/27/32/22/240_F_627322214_bUX8nE769bUOib6ZSS4yCrKUd3eeE1wO.jpg',
    'https://t4.ftcdn.net/jpg/03/28/04/53/240_F_328045380_e3pwyyywERjxU9tnc109ijXRLEuN6zLb.jpg',
    'https://images.samsung.com/is/image/samsung/assets/in/home/1103/Flip5_Yellow_D1.png?imwidth=1536',
    'https://t4.ftcdn.net/jpg/04/57/67/51/240_F_457675103_So0dkhr44cgPVGIujF0nzvmbFLC3TY6H.jpg',
    'https://t4.ftcdn.net/jpg/04/14/22/55/240_F_414225555_k4FE9n2fjaBen0QlOW1kSjaQBWfjfCjF.jpg'
  ];

  static const List<Map<String, String>> productCategory = [
    {
      'title': 'SmartPhone',
      'image': 'assets/category/smartphone.png',
    },
    {
      'title': 'Laptop',
      'image': 'assets/category/laptop.png',
    },
    {
      'title': 'Tablet',
      'image': 'assets/category/tablet.png',
    },
    {
      'title': 'Speakers',
      'image': 'assets/category/speaker.png',
    },
    {
      'title': 'SmartWatch',
      'image': 'assets/category/smartwatch.png',
    },
    {
      'title': 'HeadPhones',
      'image': 'assets/category/headphone.png',
    },
  ];
}
