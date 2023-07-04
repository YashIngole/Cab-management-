import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'database_c.dart';
//import '../databaseService.dart';
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
  // String searchQuery = "";
  // Stream? Cabs;
  // String ImageUrl = "";

  final Database_c database_c = Database_c();
  //final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        toolbarHeight: 70,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Cabs',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 22,
          right: 12,
        ),
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Cabs')
                .orderBy('C_RTO')
                .snapshots(),
            builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot,
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
