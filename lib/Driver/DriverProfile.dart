import 'package:cab_management/Driver/UpdateDriver.dart';
import 'package:cab_management/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cab_management/home.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DriverProfile extends StatelessWidget {
  final String DriverName;
  final String DriverID;
  final String Email;
  final String Phone;
  final String ImageUrl;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final String AssignCab;

  const DriverProfile(
      {super.key,
      required this.DriverName,
      required this.DriverID,
      required this.Email,
      required this.Phone,
      required this.ImageUrl,
      required this.snapshot,
      required this.AssignCab});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Driver's Profile"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  nextScreen(
                      context,
                      UpdateDriverPage(
                        DriverID: DriverID,
                        DriverName: DriverName,
                        Email: Email,
                        ImageUrl: ImageUrl,
                        Phone: Phone,
                        snapshot: snapshot,
                      ));
                },
                icon: Icon(Icons.edit)),
            Padding(padding: EdgeInsets.all(5)),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Delete"),
                        content: const Text(
                            "Are you sure you want to Delete the profile?"),
                        actions: [
                          TextButton(
                            child: const Text("No"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: const Text("Yes"),
                            onPressed: () {
                              deletedriverData();
                              nextScreen(context, Home());
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(Icons.delete)),
            Padding(padding: EdgeInsets.all(5)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ImageNetwork(
                      image: ImageUrl,
                      height: 150,
                      width: 150,
                      fitAndroidIos: BoxFit.fill,
                      fitWeb: BoxFitWeb.fill,
                      borderRadius: BorderRadius.circular(1000),
                      onError: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(226, 128, 177, 246),
                            borderRadius: BorderRadius.circular(1000)),
                        child: Center(
                            child: Text(
                          DriverName.substring(0, 1).toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: 50),
                        )),
                      ),
                    )),
              ),
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        DriverName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      "Cab Assigned : " + AssignCab,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                  ],
                ),
              ),
              /* Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Container(
                    height: 31,
                    width: 150,
                    decoration: BoxDecoration(color: Color(0xffF4F4F4)),
                    child: Center(child: Text("Driver Data:"))),
              ),*/

              Padding(
                padding: const EdgeInsets.only(left: 75, top: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, size: 30),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: KTitle('Driver ID')),
                      ],
                      
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 77),
                        child: KSubtitle(DriverID)),
                    Divider(color: Colors.black, indent: 80, endIndent: 35),
                    Row(
                      children: [
                        Icon(Icons.email_outlined, size: 30),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: KTitle('Email')),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 77),
                        child: KSubtitle(Email)),
                    Divider(color: Colors.black, indent: 80, endIndent: 35),
                    Row(
                      children: [
                        Icon(Icons.phone, size: 30),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: KTitle('Phone')),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 77),
                        child: KSubtitle(Phone)),
                    Divider(color: Colors.black, indent: 80, endIndent: 35),
                    Row(
                      children: [
                        Icon(Icons.numbers_outlined, size: 30),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: KTitle('License Number')),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 77),
                        child: KSubtitle(Phone)),
                    Divider(color: Colors.black, indent: 80, endIndent: 35),
                    Row(
                      children: [
                        Icon(Icons.date_range, size: 30),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: KTitle('Driver Join date')),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 77),
                        child: KSubtitle(Phone)),
                    Divider(color: Colors.black, indent: 80, endIndent: 35),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Padding KTitle(TitleText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        TitleText,
        style:
            TextStyle(color: Color.fromARGB(226, 128, 177, 246), fontSize: 12),
      ),
    );
  }

  Padding KSubtitle(SubtitleText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(SubtitleText,
          style: TextStyle(
            fontWeight: FontWeight.w400,
          )),
    );
  }

// delete drivers method

  void deletedriverData() async {
    var collection = FirebaseFirestore.instance.collection('drivers');
    print(DriverName);

    var querySnapshot =
        await collection.where("name", isEqualTo: DriverName.toString()).get();

    if (querySnapshot.docs.isNotEmpty) {
      var documentSnapshot = querySnapshot.docs.first;

      collection
          .doc(documentSnapshot.id)
          .delete()
          .then((_) => print('Success'))
          .catchError((error) => print('Failed: $error'));
    } else {
      print('Document not found');
    }
  }
}
