import 'package:cab_management/constants.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(selectedPage, PageController myPage, {Key? key})
      : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    var selectedPage;
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
                color: selectedPage == 1 ? Colors.blue : Colors.grey,
                icon: Icon(
                  Icons.person,
                  size: 25,
                ),
                onPressed: () {
                  var _myPage;
                  _myPage.jumpToPage(1);
                  setState(() {
                    selectedPage = 2;
                  });
                },
              ),
            ),
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: IconButton(
                onPressed: () {
                  var _myPage;
                  _myPage.jumpToPage(2);
                  setState(() {
                    selectedPage = 2;
                  });
                },
                color: selectedPage == 2 ? Colors.blue : Colors.grey,
                icon: Icon(
                  Icons.car_rental,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
