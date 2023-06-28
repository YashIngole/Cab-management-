import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

String UniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

class Database_c {
  final String? uid;
  String UniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
  Database_c({this.uid});

  // reference to the Firestore collection 'cabs'
  CollectionReference CabsRef =
      FirebaseFirestore.instance.collection('Cabs');

  // function to save the driver data to Firestore
  Future<void> saveCabsData(String C_name, String C_id, String C_type,
      String C_RTO, String ImageUrl) async {
    // new document with a unique ID in the 'drivers' collection
    DocumentReference newCabsRef = CabsRef.doc();

    // Set the data for the new driver document
    await newCabsRef.set({
      'C_name': C_name, // Driver Name
      'C_id': generateCabId(), // Driver ID Number
      'C_type': C_type, // Driver Email
      'C_RTO': C_RTO,
      'ImageUrl': ImageUrl // Driver Phone Number
    });
  }

  // Profile picture uploading and retrieving for the driver

  //reference to storage root

  //reference for image to be stored

  // Initialize references before using them
  
  //generates random driverId
  String generateCabId() {
    // Generate a random 6 digit ID
    int randomInt = Random().nextInt(900000) + 100000;
    return "CAB_$randomInt";
  }
}
