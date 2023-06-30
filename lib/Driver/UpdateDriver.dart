//import 'dart:html';

//import 'package:cab_management/Cab/cabtile.dart';
import 'package:cab_management/constants.dart';
import 'package:cab_management/firebase_options.dart';
import 'package:cab_management/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:cab_management/Cab/database_c.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

final CollectionReference Cabs =
    FirebaseFirestore.instance.collection('drivers');

//final Database_c database_c = Database_c();

class UpdateDriverPage extends StatefulWidget {
  const UpdateDriverPage({
    Key? key,
    required this.DriverName,
    required this.DriverID,
    required this.Email,
    required this.Phone,
    required this.ImageUrl,
    required this.snapshot,
  }) : super(key: key);

  final String DriverName;
  final String DriverID;
  final String Email;
  final String Phone;
  final String ImageUrl;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  @override
  State<UpdateDriverPage> createState() => _UpdatedriverPageState();
}

class _UpdatedriverPageState extends State<UpdateDriverPage> {
  String? selectedValue;

  late String newNameValue;
  late String newemail;
  late String newphonenumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Driver'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
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
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
            const Center(
              child: Text(
                'Update Profile Picture',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Assign a cab"),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                  DropdownButton<String>(
                    items: items
                        .map(
                          (String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    hint: const Text("Select an item"),
                    value: selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Icon(Icons.local_taxi),
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        newNameValue = value;
                      },
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
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
                    child: Icon(Icons.local_taxi),
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        newemail = value;
                      },
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
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
                    child: Icon(Icons.local_taxi),
                  ),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        newphonenumber = value;
                      },
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
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
            const Padding(padding: EdgeInsets.symmetric(vertical: 40)),
            ElevatedButton(
              onPressed: () {
                updateDriverData(newNameValue);
              },
              child: const Text(
                'Save',
                style: TextStyle(color: Colors.black),
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

    var querySnapshot =
        await collection.where('name', isEqualTo: widget.DriverName).get();
    await collection.where('email', isEqualTo: widget.Email).get();
    await collection.where('phone', isEqualTo: widget.Phone).get();

    if (querySnapshot.docs.isNotEmpty) {
      var documentSnapshot = querySnapshot.docs.first;

      collection
          .doc(documentSnapshot.id)
          .update({'name': newNameValue})
          .then((_) => print('Success'))
          .catchError((error) => print('Failed: $error'));
    }
    if (querySnapshot.docs.isNotEmpty) {
      var documentSnapshot = querySnapshot.docs.first;

      collection
          .doc(documentSnapshot.id)
          .update({'email': newemail})
          .then((_) => print('Success'))
          .catchError((error) => print('Failed: $error'));
    }
    if (querySnapshot.docs.isNotEmpty) {
      var documentSnapshot = querySnapshot.docs.first;

      collection
          .doc(documentSnapshot.id)
          .update({'phone': newphonenumber})
          .then((_) => print('Success'))
          .catchError((error) => print('Failed: $error'));
    } else {
      print('Document not found');
    }
  }
}
