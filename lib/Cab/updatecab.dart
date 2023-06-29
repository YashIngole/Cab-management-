import 'dart:html';

import 'package:cab_management/Cab/cabtile.dart';
import 'package:cab_management/constants.dart';
import 'package:cab_management/firebase_options.dart';
import 'package:cab_management/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cab_management/Cab/database_c.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

final CollectionReference Cabs = FirebaseFirestore.instance.collection('Cabs');

final Database_c database_c = Database_c();

class UpdateCabPage extends StatefulWidget {
  const UpdateCabPage({
    Key? key,
    required this.C_name,
    required this.C_id,
    required this.C_type,
    required this.C_RTO,
    required this.ImageUrl,
    required this.snapshot,
  }) : super(key: key);

  final String C_name;
  final String C_id;
  final String C_type;
  final String C_RTO;
  final String ImageUrl;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  @override
  State<UpdateCabPage> createState() => _UpdateCabPageState();
}

class _UpdateCabPageState extends State<UpdateCabPage> {
  String? selectedValue;

  late String newNameValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Cab'),
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
                  const Text("Assign a driver"),
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
                        labelText: 'Cab Name',
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
                        newNameValue = value;
                      },
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Cab Type',
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
                        newNameValue = value;
                      },
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'RTO passing number',
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
                updateCabData(newNameValue);
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

  void updateCabData(String newNameValue) async {
    var collection = FirebaseFirestore.instance.collection('Cabs');
    print(widget.C_name);

    var querySnapshot =
        await collection.where('C_name', isEqualTo: widget.C_name).get();
    await collection.where('C_type', isEqualTo: widget.C_name).get();
    await collection.where('C_RTO', isEqualTo: widget.C_name).get();

    if (querySnapshot.docs.isNotEmpty) {
      var documentSnapshot = querySnapshot.docs.first;

      collection
          .doc(documentSnapshot.id)
          .update({'C_name': newNameValue})
          .then((_) => print('Success'))
          .catchError((error) => print('Failed: $error'));
      collection
          .doc(documentSnapshot.id)
          .update({'C_type': newNameValue})
          .then((_) => print('Success'))
          .catchError((error) => print('Failed: $error'));
      collection
          .doc(documentSnapshot.id)
          .update({'C_RTO': newNameValue})
          .then((_) => print('Success'))
          .catchError((error) => print('Failed: $error'));
    } else {
      print('Document not found');
    }
  }
}
