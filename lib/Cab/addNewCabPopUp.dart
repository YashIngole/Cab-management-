import 'dart:typed_data';

import 'package:cab_management/Cab/cabtile.dart';
import 'package:cab_management/Cab/database_c.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
 String C_name = "";
  String C_id = "";
  String C_type = "";
  String C_RTO = "";
  final Database_c database_c = Database_c();
  String ImageUrl = "";
  String? AssignDriver;

void addNewCabPopUp(BuildContext context) {
    FirebaseFirestore.instance
        .collection('drivers')
        .get()
        .then((querySnapshot) {
      List<String> cabs = [];
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
                                    fileBytes,
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
                        ImageUrl,
                        AssignDriver == null
                            ? AssignDriver = "Not selected "
                            : AssignDriver);
                    cabtile.refreshIndicatorKey.currentState?.show();
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