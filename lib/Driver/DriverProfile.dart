import 'package:cab_management/Driver/UpdateDriver.dart';
import 'package:cab_management/Driver/addNewDriverPopUp.dart';
import 'package:cab_management/Driver/driverTile.dart';
import 'package:cab_management/constants.dart';
import 'package:cab_management/databaseService.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cab_management/home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

final DatabaseService databaseService = DatabaseService();

class DriverProfile extends StatefulWidget {
  final String DriverName;
  final String DriverID;
  final String Email;
  final String Phone;
  final String License;
  final String Joinning;
  final String ImageUrl;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final String AssignCab;

  const DriverProfile(
      {super.key,
      required this.DriverName,
      required this.DriverID,
      required this.Email,
      required this.Phone,
      required this.License,
      required this.Joinning,
      required this.ImageUrl,
      required this.snapshot,
      required this.AssignCab});

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      appBar: AppBar(
        backgroundColor: kbackgroundColor,
        title: Text(
          'Driver Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(
                    context,
                    UpdateDriverPage(
                      DriverID: widget.DriverID,
                      DriverName: widget.DriverName,
                      Email: widget.Email,
                      ImageUrl: widget.ImageUrl,
                      Phone: widget.Phone,
                      License: widget.License,
                      snapshot: widget.snapshot,
                      AssignCab: AssignCab,
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
              icon: Icon(Icons.delete_forever_outlined)),
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
                  child: defaultTargetPlatform == TargetPlatform.android
                      ? CachedNetworkImage(
                          height: 150,
                          width: 150,
                          imageUrl: widget.ImageUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(1000)),
                          ),
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) => Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                color: kImgColor,
                                borderRadius: BorderRadius.circular(1000)),
                            child: Center(
                                child: Text(
                              widget.DriverName.substring(0, 1).toUpperCase(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 50),
                            )),
                          ),
                        )
                      : ImageNetwork(
                          image: widget.ImageUrl,
                          height: 150,
                          width: 150,
                          fitAndroidIos: BoxFit.fill,
                          fitWeb: BoxFitWeb.fill,
                          borderRadius: BorderRadius.circular(1000),
                          onError: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                color: kImgColor,
                                borderRadius: BorderRadius.circular(1000)),
                            child: Center(
                                child: Text(
                              widget.DriverName.substring(0, 1).toUpperCase(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 50),
                            )),
                          ),
                        )),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    widget.DriverName,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Cab Assigned : " + widget.AssignCab,
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                  ),
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 400,
                  width: 400,
                  decoration: BoxDecoration(
                      color: kProfileContainerColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: kProfileContainerShadowColor,
                          blurRadius: 15,
                          offset: Offset(3, 3),
                          //blurStyle: BlurStyle.normal,
                        ),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Driver's Info",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 17)),
                        SizedBox(height: 18),
                        KTitle('Driver ID'),
                        KSubtitle(widget.DriverID),
                        KTitle('Email'),
                        KSubtitle(widget.Email),
                        KTitle('Phone'),
                        KSubtitle(widget.Phone),
                        KTitle('License Number'),
                        KSubtitle(widget.License),
                        KTitle('Driver Join date'),
                        KSubtitle(widget.Joinning),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding KTitle(TitleText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        TitleText,
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Padding KSubtitle(SubtitleText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Text(SubtitleText,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Color.fromARGB(192, 68, 68, 70))),
    );
  }

// delete drivers method
  void deletedriverData() async {
    var collection = FirebaseFirestore.instance.collection('drivers');
    print(widget.DriverName);

    var querySnapshot = await collection
        .where("name", isEqualTo: widget.DriverName.toString())
        .get();

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
    setState(() {
      DriverTile.refreshIndicatorKey2.currentState?.show();
    });
  }
}
