import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cab_management/Cab/Cabprofile.dart';
//import 'cabPage.dart';
import 'database_c.dart';
import 'package:cab_management/BottomNavBar.dart';
import 'package:cab_management/home.dart';
import 'package:cab_management/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class cabtile extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  const cabtile({Key? key, required this.snapshot}) : super(key: key);

  @override
  _cabTileState createState() => _cabTileState();
}

class _cabTileState extends State<cabtile> {
  late List<DocumentSnapshot> filteredList;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredList = widget.snapshot.data!.docs;
  }

  void filterData(String query) {
    final List<DocumentSnapshot> allDocs = widget.snapshot.data!.docs;
    final List<DocumentSnapshot> filteredDocs = allDocs.where((doc) {
      final Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      final String C_name = data['C_name'].toString().toUpperCase();
      return C_name.contains(query.toUpperCase());
    }).toList();
    setState(() {
      filteredList = filteredDocs;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.snapshot.hasError) {
      return Center(
        child: Text('Error: ${widget.snapshot.error}'),
      );
    }
    if (!widget.snapshot.hasData) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 50),
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: Color(0xffEBEDF3),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5),
                  child: Icon(
                    Icons.search_sharp,
                    color: Color(0xffB6B6B6),
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                      filterData(value);
                    },
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Color(0xffB6B6B6)),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            // itemCount: widget.snapshot.data!.docs.length,
            itemCount: filteredList.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot document = filteredList[index];
              final Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              final String C_name = data['C_name'].toString().toUpperCase();
              final String C_id = data['C_id'];
              final String C_type = data['C_type'];
              final String C_RTO = data['C_RTO'];
              final String ImageUrl = data['ImageUrl'];

              return Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 10, bottom: 35),
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
                          nextScreen(
                            context,
                            CabProfile(
                              C_name: C_name,
                              C_id: C_id,
                              C_type: C_type,
                              C_RTO: C_RTO,
                              ImageUrl: ImageUrl,
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            ImageNetwork(
                                image: ImageUrl,
                                borderRadius: BorderRadius.circular(15),
                                height: 69,
                                width: 77,
                                fitWeb: BoxFitWeb.fill,
                                fitAndroidIos: BoxFit.fill,
                                onError: Container(
                                  width: 77,
                                  height: 69,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Text(
                                      C_name.substring(0, 1).toUpperCase(),
                                      style: TextStyle(color: Colors.white),
                                    ),
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
                                      child: Text(
                                        C_name,
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        C_id,
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Future<Image> convertFileToImage(File ImageUrl) async {
    List<int> imageBase64 = ImageUrl.readAsBytesSync();
    String imageAsString = base64UrlEncode(imageBase64);
    Uint8List uint8list = base64.decode(imageAsString);
    Image image1 = Image.memory(uint8list);
    print(image1);
    return image1;
  }
}