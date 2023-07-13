//import 'package:cab_management/Driver/UpdateDriver.dart';
import 'package:cab_management/Cab/UpdateCab.dart';
import 'package:cab_management/Cab/cabtile.dart';
import 'package:cab_management/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import '../home.dart';

class CabProfile extends StatefulWidget {
  final String C_name;
  final String C_id;
  final String C_type;
  final String C_RTO;
  final String ImageUrl;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final String AssignDriver;

  const CabProfile(
      {super.key,
      required this.C_name,
      required this.C_id,
      required this.C_type,
      required this.C_RTO,
      required this.ImageUrl,
      required this.snapshot,
      required this.AssignDriver});

  @override
  State<CabProfile> createState() => _CabProfileState();
}

class _CabProfileState extends State<CabProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kbackgroundColor,
        appBar: AppBar(
          backgroundColor: kbackgroundColor,
          title: Text('Cab Profile'),
          centerTitle: true,
          actions: [
            Padding(padding: EdgeInsets.all(5)),
            IconButton(
                onPressed: () {
                  nextScreen(
                      context,
                      UpdateCabPage(
                        C_RTO: widget.C_RTO,
                        C_id: widget.C_id,
                        C_name: widget.C_name,
                        C_type: widget.C_type,
                        ImageUrl: widget.ImageUrl,
                        snapshot: widget.snapshot,
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
                            "Are you sure you want to Delete the Cab?"),
                        actions: [
                          TextButton(
                            child: const Text("No"),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: const Text("Yes"),
                            onPressed: () {
                              deleteCabData();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
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
                                widget.C_name.substring(0, 1).toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 50),
                              )),
                            ),
                          )),
              ),
              Center(
                child: Column(
                  children: [
                    Text(
                      widget.C_name,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
                    ),
                    Text(
                      "Driver Assigned : " + widget.AssignDriver,
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(20),
              //   child: Container(
              //       height: 31,
              //       width: double.infinity,
              //       decoration: BoxDecoration(color: Color(0xffF4F4F4)),
              //       child: Center(child: Text("Cab Data:"))),
              // ),
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
                          Text("Cab's Info",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 17)),
                          SizedBox(height: 18),
                          KTitle('Cab name'),
                          KSubtitle(widget.C_name),
                          KTitle('Cab Type'),
                          KSubtitle(widget.C_type),
                          KTitle('Registration number'),
                          KSubtitle(widget.C_RTO),
                          // KTitle('License Number'),
                          // KSubtitle(widget.Phone),
                          // KTitle('Driver Join date'),
                          // KSubtitle(widget.Phone),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
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

  // delete Cab method

  void deleteCabData() async {
    var collection = FirebaseFirestore.instance.collection('Cabs');
    print(widget.C_name);

    var querySnapshot = await collection
        .where("C_name", isEqualTo: widget.C_name.toString())
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
      cabtile.refreshIndicatorKey.currentState?.show();
    });
  }
}
