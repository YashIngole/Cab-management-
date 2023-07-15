import 'dart:async';

import 'package:cab_management/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'database_c.dart';
import 'cabtile.dart';

class thecab extends StatefulWidget {
  const thecab({Key? key}) : super(key: key);

  @override
  _thecabState createState() => _thecabState();
}

class _thecabState extends State<thecab> {
  String C_name = "";
  String C_id = "";
  String C_type = "";
  String C_RTO = "";
  String searchQuery = "";
  Stream<QuerySnapshot<Map<String, dynamic>>>? cabStream;
  String ImageUrl = "";
  String AssignDriver = "";

  final Database_c database_c = Database_c();
  final StreamController<QuerySnapshot<Map<String, dynamic>>>
      _streamController =
      StreamController<QuerySnapshot<Map<String, dynamic>>>();

  @override
  void initState() {
    super.initState();
    cabStream = FirebaseFirestore.instance
        .collection('Cabs')
        .orderBy('C_RTO')
        .snapshots();

    cabStream!.listen((snapshot) {
      _streamController.add(snapshot);
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: Padding(
        padding: EdgeInsets.only(
          left: 22,
          right: 12,
        ),
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: _streamController.stream,
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot,
            ) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return cabtile(
                snapshot: snapshot,
              );
            },
          ),
        ),
      ),
    );
  }
}
