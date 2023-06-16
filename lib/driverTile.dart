// ignore: file_names
// ignore_for_file: prefer_const_constructors, file_names, duplicate_ignore, prefer_interpolation_to_compose_strings, sort_child_properties_last

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
    return Expanded(
      child: ListView(
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
              child: Row(
                children: [
                  Container(
                    height: 69,
                    width: 77,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: Text(
                              DriverName,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              DriverID,
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15, left: 8),
                            child: Container(
                              height: 0.15,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
