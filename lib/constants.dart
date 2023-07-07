import 'package:flutter/material.dart';

const kbackgroundColor = Color(0xffebedf3);
const kImgColor = Color.fromARGB(226, 128, 177, 246);
const kChevronArrowColor = Color.fromARGB(226, 128, 177, 246);
const kSearchbarColor = Color.fromARGB(234, 193, 219, 255);
const kDriverTileShadowColor = Color.fromARGB(248, 99, 31, 167);

//home page
const kSelectedIconColor = Colors.blue;
const kUnselectedIconColor = Colors.grey;
const kRegisterbuttonColor =
    Colors.lightGreen; //Add cab/driver popup register button color
const kCancelbuttonColor = Color.fromARGB(255, 182, 179, 179);
const kFloatingActionbuttonColor = Color.fromARGB(255, 99, 171, 240);

//Save/register button lineargradients
const kGrad1 = Color.fromARGB(255, 63, 113, 221);
const kGrad2 = Color.fromARGB(255, 62, 80, 243);
const kGrad3 = Color.fromARGB(255, 56, 181, 240);

class constansts {
  static String appId = "1:548481446524:web:eccf274548459200c30ff9";
  static String apiKey = "AIzaSyAWcaGI0pBcYzfKk3FC4xBdOGmV9PCXkUw";
  static String messagingSenderId = "548481446524";
  static String projectId = "cab-management-7b661";
}

void nextScreen(context, page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

void nextScreenReplace(context, page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}

List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
];
