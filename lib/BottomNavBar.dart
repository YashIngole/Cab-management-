import 'package:cab_management/cabPage.dart';
import 'package:cab_management/constants.dart';
import 'package:cab_management/home.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 70,
      color: kbackgroundColor,
      shape: CircularNotchedRectangle(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: IconButton(
                icon: Icon(
                  Icons.person,
                  size: 25,
                ),
                onPressed: () {
                  nextScreen(context, home());
                },
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: IconButton(
                icon: Icon(
                  Icons.car_rental,
                  size: 25,
                ),
                onPressed: () {
                  nextScreen(context, cabPage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
