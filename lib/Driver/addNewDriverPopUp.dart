import 'dart:typed_data';

import 'package:cab_management/Driver/driverTile.dart';
import 'package:cab_management/databaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Stream? Cabs;
String name = "";
String id = "";
String email = "";
String phone = "";
String? AssignCab;
String ImageUrl = "";
final DatabaseService databaseService = DatabaseService();
void addNewDriverPopUp(BuildContext context) {
  FirebaseFirestore.instance.collection('Cabs').get().then((querySnapshot) {
    List<String> cabs = []; // Create an empty list to store cab names
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
                                  fileBytes,
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
                        hint: Text("Assign a Cab"),
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                  setState(
                    () {},
                  );
                  await databaseService.saveDriverData(
                      name.toUpperCase(),
                      id.toUpperCase(),
                      email,
                      phone,
                      ImageUrl,
                      AssignCab == null
                          ? AssignCab = "Not selected "
                          : AssignCab);
                  DriverTile.refreshIndicatorKey2.currentState?.show();
                  Navigator.of(context).pop();

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