import 'package:cab_management/BottomNavBar.dart';
import 'package:cab_management/Driver/DriverPage.dart';
import 'package:cab_management/Cab/cabPage.dart';
import 'package:cab_management/constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'databaseService.dart';
import 'Driver/driverTile.dart';
import 'firebase_options.dart';
import 'dart:js_util';
import 'package:js/js.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  String name = "";
  String id = "";
  String email = "";
  String phone = "";
  final DatabaseService databaseService = DatabaseService();
  Stream? drivers;

  late PageController _myPage;
  var selectedPage;

  @override
  void initState() {
    super.initState();
    _myPage = PageController(initialPage: 0);
    selectedPage = 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedPage = index;

      _myPage.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _myPage,
          children: <Widget>[DriverPage(), cabPage()],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AddNewDriverPopUp(context);
          },
          child: Icon(Icons.add, color: Colors.white),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavBar());
  }

  BottomAppBar BottomNavBar() {
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

  AddNewDriverPopUp(BuildContext context) {
    String FieldText = '';
    IconData KIconName;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              // insetPadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              title: const Text(
                "Add Driver",
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 100,
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(1000)),
                            child: Center(
                                child: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size: 50,
                            )),
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Update Profile Picture',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(top: 50)),
                      KUpdateField(FieldText = 'Driver Name', Icons.person),
                      KUpdateField(
                          FieldText = 'Email', KIconName = Icons.email),
                      KUpdateField(
                          FieldText = 'Phone', KIconName = Icons.phone),
                      KUpdateField(FieldText = 'License Number',
                          KIconName = Icons.badge),
                      Padding(padding: EdgeInsets.symmetric(vertical: 40)),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Save',
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text(
                    "CANCEL",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await databaseService.saveDriverData(
                        name, id, email, phone);

                    nextScreenReplace(context, home());

                    SnackBar(
                        content: Center(
                      child: Text('Driver Registered Successfully'),
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen),
                  child: const Text(
                    "CREATE",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            );
          }));
        });
  }
}
