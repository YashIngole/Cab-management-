import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

String UniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

class DatabaseService {
  final String? uid;
  String UniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  DatabaseService({this.uid});

  // reference to the Firestore collection 'drivers'
  CollectionReference driversRef =
      FirebaseFirestore.instance.collection('drivers');

  // function to save the driver data to Firestore
  Future<void> saveDriverData(String name, String id, String email,
      String phone, String ImageUrl) async {
    // new document with a unique ID in the 'drivers' collection
    DocumentReference newDriverRef = driversRef.doc();

    // Set the data for the new driver document
    await newDriverRef.set({
      'name': name, // Driver Name
      'id': generateDriverId(), // Driver ID Number
      'email': email, // Driver Email
      'phone': phone,
      'ImageUrl': ImageUrl // Driver Phone Number
    });
  }

  // Profile picture uploading and retrieving for the driver

  //reference to storage root

  //reference for image to be stored

  // Initialize references before using them
  
  //generates random driverId
  String generateDriverId() {
    // Generate a random 6 digit ID
    int randomInt = Random().nextInt(900000) + 100000;
    return "DRV_$randomInt";
  }
}
