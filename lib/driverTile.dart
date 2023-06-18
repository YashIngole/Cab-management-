// ignore: file_names
// ignore_for_file: prefer_const_constructors, file_names, duplicate_ignore, prefer_interpolation_to_compose_strings, sort_child_properties_last

import 'package:cab_management/DriverPage.dart';
import 'package:cab_management/DriverProfile.dart';
import 'package:cab_management/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DriverTile extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  const DriverTile({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
    final querySnapshot = snapshot.data!;
    return ListView(
      shrinkWrap: false,
      children: querySnapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        String DriverName = data['name'];
        String DriverID = data['id'];
        String Email = data['email'];
        String Phone = data['phone'];

        return Padding(
          padding: const EdgeInsets.only(right: 20, bottom: 35),
          child: Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: Colors.white,
                shadowColor: Colors.white,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                side: BorderSide.none,
                backgroundColor: Color(0xffffffff),
              ),
              onPressed: () {
                // nextScreen(context, DriverProfile());
              },
              child: Row(
                children: [
                  Container(
                      height: 69,
                      width: 77,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15)),
                      child: Center(
                        child: Text(
                          DriverName.substring(0, 1).toUpperCase(),
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(DriverName,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              DriverID,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 15, left: 8),
                          //   child: Container(
                          //     height: 0.15,
                          //     color: Colors.black,
                          //   ),
                          // )
                        ],
                      ),
                    ),
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Colors.black12,
                  )
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
