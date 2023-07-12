import 'package:cab_management/Auth/navBar.dart';
import 'package:cab_management/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../databaseService.dart';
import 'driverTile.dart';

class DriverPage extends StatefulWidget {
  const DriverPage({Key? key}) : super(key: key);

  @override
  _DriverPageState createState() => _DriverPageState();
}

class _DriverPageState extends State<DriverPage> {
  String name = "";
  String id = "";
  String email = "";
  String phone = "";
  String searchQuery = "";
  bool _isLoading = false;

  final DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      
      body: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : Padding(
              padding: EdgeInsets.only(
                left: 22,
                right: 12,
              ),
              child: SafeArea(
                child: StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('drivers')
                          .orderBy('name')
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
                          _isLoading == true;
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return DriverTile(
                          snapshot: snapshot,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
    );
  }
}
