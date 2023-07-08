import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';
import 'package:cab_management/Cab/addNewCabPopUp.dart';
import 'package:cab_management/Cab/therealcabpage.dart';
import 'package:cab_management/Driver/DriverPage.dart';
import 'package:cab_management/Driver/DriverProfile.dart';
import 'package:cab_management/Driver/addNewDriverPopUp.dart';
import 'package:cab_management/constants.dart';
import 'package:cab_management/responsive.dart';
import 'package:cab_management/sideScreenDesktop.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> cabs = [];
  var NewDriverRef;
  late PageController _myPage;
  var selectedPage;
  String inputValue = '';

  @override
  void initState() {
    super.initState();
    _myPage = PageController(initialPage: 0);
    selectedPage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Responsive(
      Mobile: Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _myPage,
          children: <Widget>[DriverPage(), thecab()],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selectedPage == 0) {
              addNewDriverPopUp(context);
            } else {
              addNewCabPopUp(context);
            }
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: bottomNavBar(),
      ),
      Desktop: Row(
        children: [
          Expanded(
            child: Scaffold(
              body: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _myPage,
                children: <Widget>[DriverPage(), thecab()],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (selectedPage == 0) {
                    addNewDriverPopUp(context);
                  } else {
                    addNewCabPopUp(context);
                  }
                },
                child: Icon(Icons.add, color: Colors.white),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: bottomNavBar(),
            ),
          ),
          Expanded(
            child: SideScreenDesktop(),
          )
        ],
      ),
    );
  }

  BottomAppBar bottomNavBar() {
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
                color: selectedPage == 0 ? Colors.blue : Colors.grey,
                icon: Icon(
                  Icons.person,
                  size: 25,
                ),
                onPressed: () {
                  _myPage.jumpToPage(0);
                  setState(() {
                    selectedPage = 0;
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
                  _myPage.jumpToPage(1);
                  setState(() {
                    selectedPage = 1;
                  });
                },
                color: selectedPage == 1 ? Colors.blue : Colors.grey,
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

  Future<Image> convertFileToImage(File picture) async {
    List<int> imageBase64 = picture.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    Image image = Image.memory(uint8list);
    return image;
  }
}
