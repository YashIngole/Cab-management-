import 'dart:convert';
import 'dart:io';

import 'dart:typed_data';
import 'package:cab_management/Cab/addNewCabPopUp.dart';
import 'package:cab_management/Cab/therealcabpage.dart';
import 'package:cab_management/Driver/DriverPage.dart';
import 'package:cab_management/Driver/addNewDriverPopUp.dart';
import 'package:cab_management/constants.dart';
import 'package:flutter/material.dart';
import 'Auth/navBar.dart';

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
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: selectedPage == 0
              ? Text(
                  'Drivers',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                )
              : Text(
                  'Cabs',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                ),
        ),
        centerTitle: true,
      ),
      drawer: navBar(),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _myPage,
        children: <Widget>[DriverPage(), thecab()],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kFloatingActionbuttonColor,
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
    );
  }

  BottomAppBar bottomNavBar() {
    return BottomAppBar(
      height: 70,
      color: kbottomNavColor,
      shape: CircularNotchedRectangle(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                children: [
                  IconButton(
                    color: kSelectedIconColor,
                    icon: selectedPage == 0
                        ? ImageIcon(AssetImage("assets/driver_se.png"))
                        : ImageIcon(AssetImage("assets/driver_un.png")),
                    onPressed: () {
                      _myPage.jumpToPage(0);
                      setState(() {
                        selectedPage = 0;
                      });
                    },
                  ),
                ],
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
                  color: kSelectedIconColor,
                  icon: selectedPage == 1
                      ? ImageIcon(AssetImage("assets/cab_se.png"))
                      : ImageIcon(AssetImage("assets/cab_un.png"))),
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
