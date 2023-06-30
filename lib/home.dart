import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cab_management/Auth/navBar.dart';
import 'package:cab_management/Cab/cabtile.dart';
import 'package:cab_management/Cab/therealcabpage.dart';
import 'package:cab_management/Driver/DriverPage.dart';
import 'package:cab_management/Cab/therealcabpage.dart';
import 'package:cab_management/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cab_management/databaseService.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'databaseService.dart';
import 'Cab/database_c.dart';
import 'firebase_options.dart';
import 'dart:js_util';
import 'package:js/js.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String C_name = "";
  String C_id = "";
  String C_type = "";
  String C_RTO = "";

  Stream? Cabs;
  String name = "";
  String id = "";
  String email = "";
  String phone = "";
  final DatabaseService databaseService = DatabaseService();
  final Database_c database_c = Database_c();
  Stream? drivers;
  String ImageUrl = "";
  List<String> cabs = [];

  var NewDriverRef;
  late PageController _myPage;
  var selectedPage;

  String inputValue = '';

  String? AssignDriver;
  String? AssignCab;

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

  void addNewCabPopUp(BuildContext context) {
    FirebaseFirestore.instance
        .collection('drivers')
        .get()
        .then((querySnapshot) {
      List<String> cabs = ['not selected'];
      querySnapshot.docs.forEach((doc) {
        var driverName = doc.data()['name'].toString().toUpperCase();
        cabs.add(driverName);
      });

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.all(10),
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              title: const Text(
                "Add Cab",
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(1000),
                            onTap: () async {
                              ImagePicker imagePicker = ImagePicker();
                              XFile? file = await imagePicker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (file == null) {
                                return;
                              }
                              final Uint8List fileBytes =
                                  await file.readAsBytes();

                              Reference referenceRoot =
                                  FirebaseStorage.instance.ref();
                              Reference referenceDirImages =
                                  referenceRoot.child('images');

                              String uniqueFileName = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString() +
                                  '.jpg';
                              Reference referenceImageToUpload =
                                  referenceDirImages.child(uniqueFileName);
                              try {
                                await referenceImageToUpload.putData(
                                    fileBytes as Uint8List,
                                    SettableMetadata(
                                        contentType: 'image/jpeg'));
                                ImageUrl = await referenceImageToUpload
                                    .getDownloadURL();
                                print(ImageUrl);
                              } catch (e) {
                                print('Error uploading image: $e');
                              }
                            },
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(1000),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 150),
                        child: DropdownButtonFormField<String>(
                          validator: (value) {
                            if (value == null) {
                              return 'Relationship is required';
                            }
                          },
                          items: cabs.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                          hint: Text("Assign a Driver"),
                          value: cabs[0],
                          onChanged: (String? value) {
                            setState(() {
                              AssignDriver = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(Icons.person),
                            ),
                            Expanded(
                              child: TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    C_name = val.toLowerCase();
                                  });
                                },
                                style: TextStyle(),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Cab Name',
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(Icons.directions_car),
                            ),
                            Expanded(
                              child: TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    C_type = val;
                                  });
                                },
                                style: TextStyle(),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Cab Type',
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(Icons.numbers),
                            ),
                            Expanded(
                              child: TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    C_RTO = val;
                                  });
                                },
                                style: TextStyle(),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'RTO Passing no.',
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                            )
                          ],
                        ),
                      ),
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
                    await database_c.saveCabsData(
                        C_name.toUpperCase(),
                        C_id.toUpperCase(),
                        C_type.toUpperCase(),
                        C_RTO.toUpperCase(),
                        ImageUrl);

                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(
                          child: Text('Cab Registered Successfully'),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          });
        },
      );
    }).catchError((error) {
      print('Error fetching cabs: $error');
    });
  }

  void addNewDriverPopUp(BuildContext context) {
    FirebaseFirestore.instance.collection('Cabs').get().then((querySnapshot) {
      List<String> cabs = [
        'not selected'
      ]; // Create an empty list to store cab names
      querySnapshot.docs.forEach((doc) {
        var cName = doc.data()['C_name'].toString().toUpperCase();
        var cRTO = doc.data()['C_RTO'].toString().toUpperCase();
        cabs.add(cRTO + " - " + cName);
        print(cabs);
      });

      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              insetPadding: EdgeInsets.all(10),
              contentPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              title: const Text(
                "Add Driver",
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(1000),
                            onTap: () async {
                              ImagePicker imagePicker = ImagePicker();
                              XFile? file = await imagePicker.pickImage(
                                source: ImageSource.gallery,
                              );
                              if (file == null) {
                                return;
                              }
                              //convert file to data
                              final Uint8List fileBytes =
                                  await file.readAsBytes();

                              // Reference to storage root of Firebase Storage
                              Reference referenceRoot =
                                  FirebaseStorage.instance.ref();
                              Reference referenceDirImages =
                                  referenceRoot.child('images');

                              // Reference for the image to be stored
                              String uniqueFileName = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString() +
                                  '.jpg';
                              Reference referenceImageToUpload =
                                  referenceDirImages.child(uniqueFileName);
                              try {
                                // Store the file
                                await referenceImageToUpload.putData(
                                    fileBytes as Uint8List,
                                    SettableMetadata(
                                        contentType: 'image/jpeg'));
                                ImageUrl = await referenceImageToUpload
                                    .getDownloadURL();
                                print(ImageUrl);
                              } catch (e) {
                                print('Error uploading image: $e');
                              }
                            },
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(1000),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            ),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 150),
                        child: DropdownButtonFormField<String>(
                          validator: (value) {
                            if (value == null) {
                              return 'Relationship is required';
                            }
                          },
                          items: cabs.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            );
                          }).toList(),
                          hint: Text("Assign a Cab"),
                          value: cabs[0],
                          onChanged: (String? value) {
                            setState(() {
                              AssignCab = value;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(Icons.person),
                            ),
                            Expanded(
                              child: TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    name = val.toLowerCase();
                                  });
                                },
                                style: TextStyle(),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Name',
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(Icons.email),
                            ),
                            Expanded(
                              child: TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                                style: TextStyle(),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Email',
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(Icons.phone),
                            ),
                            Expanded(
                              child: TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    phone = val;
                                  });
                                },
                                style: TextStyle(),
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Phone',
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                            )
                          ],
                        ),
                      ),
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
                    await databaseService.saveDriverData(name.toUpperCase(),
                        id.toUpperCase(), email, phone, ImageUrl);

                    nextScreenReplace(context, Home());

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(
                          child: Text('Driver Registered Successfully'),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                  ),
                  child: const Text(
                    "Register",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            );
          });
        },
      );
    }).catchError((error) {
      // Handle any potential errors here
      print('Error fetching cabs: $error');
    });
  }

  Future<Image> convertFileToImage(File picture) async {
    List<int> imageBase64 = picture.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    Image image = Image.memory(uint8list);
    return image;
  }
}
