import 'package:flutter/material.dart';

const kbackgroundColor = Color(0xffebedf3);

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
