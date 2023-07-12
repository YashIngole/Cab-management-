import 'dart:typed_data';
import 'package:cab_management/Cab/addNewCabPopUp.dart';
import 'package:cab_management/Driver/addNewDriverPopUp.dart';
import 'package:cab_management/constants.dart';
import 'package:cab_management/firebase_options.dart';
import 'package:cab_management/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';

final CollectionReference Cabs =
    FirebaseFirestore.instance.collection('drivers');

class UpdateDriverPage extends StatefulWidget {
  const UpdateDriverPage({
    Key? key,
    required this.DriverName,
    required this.DriverID,
    required this.Email,
    required this.Phone,
    required this.ImageUrl,
    required this.snapshot,
    required this.AssignCab,
    required this.License,
  }) : super(key: key);

  final String DriverName;
  final String DriverID;
  final String Email;
  final String Phone;
  final String License;
  final String ImageUrl;
  final String? AssignCab;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  @override
  State<UpdateDriverPage> createState() => _UpdatedriverPageState();
}

class _UpdatedriverPageState extends State<UpdateDriverPage> {
  List<String> cabs = []; // Declare the cabs list here

  @override
  void initState() {
    super.initState();
    fetchcablist();
  }

  String? selectedValue;

  String newNameValue = '';
  String newemail = '';
  String newphonenumber = '';
  String newlicense = '';
  String NewImageUrl = '';

  void fetchcablist() {
    FirebaseFirestore.instance.collection('Cabs').get().then((querySnapshot) {
      List<String> cabList = []; // Create an empty list to store cab names
      querySnapshot.docs.forEach((doc) {
        var cName = doc.data()['C_name'].toString().toUpperCase();
        var cRTO = doc.data()['C_RTO'].toString().toUpperCase();
        cabList.add(cRTO + " - " + cName);
      });

      setState(() {
        cabs = cabList; // Assign the fetched cab names to the class-level list
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(cabs);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Driver',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(500),
                      onTap: () async {
                        ImagePicker imagePicker = ImagePicker();
                        XFile? file = await imagePicker.pickImage(
                          source: ImageSource.gallery,
                        );
                        if (file == null) {
                          return;
                        }
                        final Uint8List fileBytes = await file.readAsBytes();

                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                            referenceRoot.child('images');

                        String uniqueFileName =
                            DateTime.now().millisecondsSinceEpoch.toString() +
                                '.jpg';
                        Reference referenceImageToUpload =
                            referenceDirImages.child(uniqueFileName);
                        try {
                          await referenceImageToUpload.putData(fileBytes,
                              SettableMetadata(contentType: 'image/jpeg'));
                          NewImageUrl =
                              await referenceImageToUpload.getDownloadURL();
                          print(NewImageUrl);
                          setState(
                            () {
                              NewImageUrl;
                            },
                          );
                        } catch (e) {
                          print('Error uploading image: $e');
                        }
                      },
                      child: NewImageUrl.isEmpty
                          ? Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                color: kImgColor,
                                borderRadius: BorderRadius.circular(1000),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ),
                            )
                          : ImageNetwork(
                              image: NewImageUrl, height: 150, width: 150))),
            ),
            const Center(
              child: Text(
                'Update Profile Picture',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text("Assign a cab"),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10)),
                    Expanded(
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
                            selectedValue = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
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
                      initialValue: widget.DriverName,
                      onChanged: (value) {
                        newNameValue = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(13)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Name',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 1)),
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
                      initialValue: widget.Email,
                      onChanged: (value) {
                        newemail = value;
                      },
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(13)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
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
                      initialValue: widget.Phone,
                      onChanged: (value) {
                        newphonenumber = value;
                      },
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(13)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'phone number',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.document_scanner),
                  ),
                  Expanded(
                    child: TextFormField(
                      initialValue: widget.License,
                      onChanged: (value) {
                        newlicense = value;
                      },
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(13)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(12)),
                        labelText: 'Lisence number',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 35)),
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kGrad1, kGrad2, kGrad3],
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: ElevatedButton(
                onPressed: () {
                  updateDriverData(newNameValue);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      duration: const Duration(milliseconds: 900),
                      content: Center(
                        child: Text('Driver Updated Successfully'),
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Save',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(200, 50),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateDriverData(String newNameValue) async {
    var collection = FirebaseFirestore.instance.collection('drivers');
    print(widget.DriverName);

    var querySnapshot = await collection
        .where('name', isEqualTo: widget.DriverName.toUpperCase())
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      var documentSnapshot = querySnapshot.docs.first;
      newNameValue.isNotEmpty
          ? collection
              .doc(documentSnapshot.id)
              .update({'name': newNameValue.toUpperCase()})
              .then((_) => print('Success'))
              .catchError((error) => print('Failed: $error'))
          : collection
              .doc(documentSnapshot.id)
              .update({'name': widget.DriverName.toUpperCase()})
              .then((_) => print('Success'))
              .catchError((error) => print('Failed: $error'));
      if (querySnapshot.docs.isNotEmpty) {
        var documentSnapshot = querySnapshot.docs.first;
        NewImageUrl.isNotEmpty
            ? collection
                .doc(documentSnapshot.id)
                .update({'ImageUrl': NewImageUrl})
                .then((_) => print('Success'))
                .catchError((error) => print('Failed: $error'))
            : collection
                .doc(documentSnapshot.id)
                .update({'ImageUrl': widget.ImageUrl})
                .then((_) => print('Success'))
                .catchError((error) => print('Failed: $error'));
      }
      if (querySnapshot.docs.isNotEmpty) {
        var documentSnapshot = querySnapshot.docs.first;
        newemail.isNotEmpty
            ? collection
                .doc(documentSnapshot.id)
                .update({'email': newemail})
                .then((_) => print('Success'))
                .catchError((error) => print('Failed: $error'))
            : collection
                .doc(documentSnapshot.id)
                .update({'email': widget.Email})
                .then((_) => print('Success'))
                .catchError((error) => print('Failed: $error'));
      }
      if (querySnapshot.docs.isNotEmpty) {
        var documentSnapshot = querySnapshot.docs.first;
        newphonenumber.isNotEmpty
            ? collection
                .doc(documentSnapshot.id)
                .update({'phone': newphonenumber})
                .then((_) => print('Success'))
                .catchError((error) => print('Failed: $error'))
            : collection
                .doc(documentSnapshot.id)
                .update({'phone': widget.Phone})
                .then((_) => print('Success'))
                .catchError((error) => print('Failed: $error'));
      }
      if (querySnapshot.docs.isNotEmpty) {
        var documentSnapshot = querySnapshot.docs.first;
        newlicense.isNotEmpty
            ? collection
                .doc(documentSnapshot.id)
                .update({'license': newlicense})
                .then((_) => print('Success'))
                .catchError((error) => print('Failed: $error'))
            : collection
                .doc(documentSnapshot.id)
                .update({'license': widget.License})
                .then((_) => print('Success'))
                .catchError((error) => print('Failed: $error'));
      } else {
        print('Document not found');
      }
    }
  }
}
