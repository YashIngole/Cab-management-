import 'package:flutter/material.dart';

// // theme 1
// const kbackgroundColor = Color(0xffDBE9EE);
// const kImgColor = Color(0xff4f6d7a);
// const kChevronArrowColor = Color.fromARGB(226, 128, 177, 246);
// const kSearchbarColor = Color(0xffc0d6df);
// const kDriverTileShadowColor = Color.fromARGB(248, 99, 31, 167);
// const kdriversubtitle = Color(0xff4a6fa5);
// const kdrivertitle = Color(0xff166088);
// const kFloatingActionbuttonColor = Color(0xff4a6fa5);
// const kSelectedIconColor = Color(0xff4f6d7a);
// const kUnselectedIconColor = Colors.grey;
// const kbottomNavColor = Color(0xffc0d6df);

//theme 2
// const kbackgroundColor = Color(0xffede0d4);
// const kImgColor = Color(0xff7f5539);
// const kChevronArrowColor = Color.fromARGB(226, 128, 177, 246);
// const kSearchbarColor = Color(0xffe6ccb2);
// const kDriverTileShadowColor = Color.fromARGB(248, 99, 31, 167);
// const kdriversubtitle = Color(0xff9c6644);
// const kdrivertitle = Color(0xff7f2239);
// const kFloatingActionbuttonColor = Color(0xffe6ccb2);
// const kSelectedIconColor = Color(0xff7f2239);
// const kUnselectedIconColor = Color(0xffe6ccb2);
// const kbottomNavColor = Color(0xffddb892);

const kbackgroundColor = Color(0xffECECEC);
const kImgColor = Color(0xff8FB2B9);
const kChevronArrowColor = Color.fromARGB(226, 128, 177, 246);
const kSearchbarColor = Color(0xffC2C2C2);
const kDriverTileShadowColor = Color.fromARGB(223, 199, 156, 242);
const kdriversubtitle = Color(0xff9E9E9E);
const kdrivertitle = Color.fromARGB(255, 70, 70, 70);
const kFloatingActionbuttonColor = Color(0xff4f6d7a);
const kSelectedIconColor = Color(0xff4f6d7a);
const kUnselectedIconColor = Color.fromARGB(255, 197, 213, 215);
const kbottomNavColor = Color(0xff9E9E9E);

//driver/cab profile info container
const kProfileContainerColor = Color.fromARGB(244, 237, 246, 255);
const kProfileContainerShadowColor = Color.fromARGB(255, 226, 216, 252);

//home page

const kRegisterbuttonColor =
    Colors.lightGreen; //Add cab/driver popup register button color
const kCancelbuttonColor = Color.fromARGB(255, 182, 179, 179);

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