import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'cabtile.dart';
import 'package:cab_management/Driver/DriverPage.dart';
//import 'package:cab_management/Cab/cabPage.dart';
import 'package:cab_management/constants.dart';
import 'package:cab_management/home.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'database_c.dart';

import 'therealcabpage.dart';
import 'dart:js_util';
import 'package:js/js.dart';

class cabPage extends StatefulWidget {
  const cabPage({Key? key}) : super(key: key);

  @override
  _cabState createState() => _cabState();
}

class _cabState extends State<cabPage> {
  String C_name = "";
  String C_id = "";
  String C_type = "";
  String C_RTO = "";
  final Database_c database_c = Database_c();
  Stream? Cabs;
  String ImageUrl = "";

  late PageController _myPage;
  var selectedPage;

  String inputValue = '';

  @override
  void initState() {
    super.initState();
    _myPage = PageController(initialPage: 0);
    selectedPage = 1;
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          addNewCabPopUp(context);}
      
      ),
    );
  }

  void addNewCabPopUp(BuildContext context) {
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
                                  SettableMetadata(contentType: 'image/jpeg'));
                              ImageUrl =
                                  await referenceImageToUpload.getDownloadURL();
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
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      C_name, C_id, C_type, C_RTO, ImageUrl);

                  nextScreenReplace(context, Home());

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
  }

  Future<Image> convertFileToImage(File picture) async {
    List<int> imageBase64 = picture.readAsBytesSync();
    String imageAsString = base64Encode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    Image image = Image.memory(uint8list);
    return image;
  }
}
