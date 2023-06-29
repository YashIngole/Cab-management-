//import 'package:cab_management/Driver/UpdateDriver.dart';
import 'package:cab_management/Cab/UpdateCab.dart';
import 'package:cab_management/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class CabProfile extends StatefulWidget {
  final String C_name;
  final String C_id;
  final String C_type;
  final String C_RTO;
  final String ImageUrl;
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  const CabProfile(
      {super.key,
      required this.C_name,
      required this.C_id,
      required this.C_type,
      required this.C_RTO,
      required this.ImageUrl,
      required this.snapshot});

  @override
  State<CabProfile> createState() => _CabProfileState();
}

class _CabProfileState extends State<CabProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cab Profile'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  nextScreen(
                      context,
                      UpdateCabPage(
                        C_RTO: widget.C_RTO,
                        C_id: widget.C_id,
                        C_name: widget.C_name,
                        C_type: widget.C_type,
                        ImageUrl: widget.ImageUrl, snapshot: widget.snapshot,
                      ));
                },
                icon: Icon(Icons.edit)),
            Padding(padding: EdgeInsets.all(5)),
            IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
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
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(1000)),
                        child: Center(
                            child: Text(
                          widget.C_name.substring(0, 1).toUpperCase(),
                          style: TextStyle(color: Colors.white, fontSize: 50),
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
                      "Driver Assigned :",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                    height: 31,
                    width: double.infinity,
                    decoration: BoxDecoration(color: Color(0xffF4F4F4)),
                    child: Center(child: Text("Cab Data:"))),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KTitle('Cab ID'),
                    KSubtitle(widget.C_id),
                    KTitle('Cab Type'),
                    KSubtitle(widget.C_type),
                    KTitle('RTO Passing no.'),
                    KSubtitle(widget.C_RTO),
                    // KTitle('License Number'),
                    // KSubtitle(Phone),
                    // KTitle('Driver Join date'),
                    // KSubtitle(Phone),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Padding KTitle(TitleText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        TitleText,
        style: TextStyle(color: Color(0xff959595)),
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
}
