import 'package:cab_management/cabPage.dart';
import 'package:cab_management/constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'databaseService.dart';
import 'driverTile.dart';
//import 'firebase_options.dart';
//import 'dart:js_util';
//import 'package:js/js.dart';

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

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      bottomNavigationBar: BottomAppBar(
        elevation: 20,
        height: 70,
        color: Color(0xffFAFAFA),
        child: Container(
          child: Row(
            children: [
              Expanded(
                child: IconButton(
                  onPressed: () {
                    nextScreen(context, cabPage());
                  },
                  icon: Icon(Icons.car_rental),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.person),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.settings),
                ),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 30, bottom: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "  Drivers",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Container(
                      child: SearchBar(
                        hintText: "Search",
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 13,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 2.0,
                            offset: Offset(0.0, 1.5))
                      ],
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xff6AEA2E),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.search_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 42, right: 12, top: 43),
              child: Flexible(
                  child: Container(
                constraints: BoxConstraints.tightForFinite(height: 800),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
                  color: Colors.white,
                ),
                width: double.maxFinite,
                child: SafeArea(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffFBE0E0),
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {
                            AddNewDriverPopUp(context);
                          },
                          child: Text(
                            "Add New Driver",
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('drivers')
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          }
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }

                          return DriverTile(
                            snapshot: snapshot,
                          );
                        },
                      ),
                    )
                  ],
                )),
              )),
            ),
          ],
        )),
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
                          name = val;
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
