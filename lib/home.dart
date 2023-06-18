import 'package:cab_management/BottomNavBar.dart';
import 'package:cab_management/DriverPage.dart';
import 'package:cab_management/cabPage.dart';
import 'package:cab_management/constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'databaseService.dart';
import 'driverTile.dart';
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
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              title: const Text(
                "Add Driver",
                textAlign: TextAlign.center,
              ),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          name = val.toLowerCase();
                        });
                      },
                      decoration: InputDecoration(
                          labelText: "Name",
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(20)),
                          errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      validator: (val) {
                        return RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(val!)
                            ? null
                            : "Please enter a valid email";
                      },
                      decoration: InputDecoration(
                          labelText: "Email",
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(20)),
                          errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          phone = val;
                        });
                      },
                      validator: (val) {
                        if (val!.length < 6) {
                          return "Password must be at least 6 characters";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "phone number",
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(20)),
                          errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.red),
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.green),
                              borderRadius: BorderRadius.circular(20))),
                    ),
                  ),
                ],
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

                    // Navigator.of(context).pop();
                    // showSnackbar(
                    //     context, Colors.green, "Group created successfully.");
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
