import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
   final String? uid;
  DatabaseService({this.uid});

   // reference to the Firestore collection 'drivers'
   CollectionReference CabsRef =
        FirebaseFirestore.instance.collection('Cabs');
// function to save the driver data to Firestore
  Future<void> saveCAbData(
      String C_name, String C_id, String C_model, String RTO_number) async {
   
   

    // new document with a unique ID in the 'drivers' collection
    DocumentReference newCabRef = CabsRef.doc();

    // Set the data for the new driver document

    await newCabRef.set({
      'Cab name': C_name, // cab Name
      'Cab id': generateCabId(), // cab ID Number
      'Cab Model': C_model, // cab model
      'RTO Passing number': RTO_number, // rto passing number
    });
    
  }
  

  String generateCabId() {
    // Generate a random 6 digit ID
    int randomInt = Random().nextInt(900000) + 100000;
    return "CAB_$randomInt";
  }

  saveDriverData(String name, String id, String email, String phone) {}
}
