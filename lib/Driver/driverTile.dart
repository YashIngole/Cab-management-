import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cab_management/Driver/DriverProfile.dart';
import 'package:cab_management/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class DriverTile extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  static GlobalKey<RefreshIndicatorState> refreshIndicatorKey2 =
      GlobalKey<RefreshIndicatorState>();
  const DriverTile({Key? key, required this.snapshot}) : super(key: key);

  @override
  _DriverTileState createState() => _DriverTileState();
}

class _DriverTileState extends State<DriverTile> {
  late Stream<QuerySnapshot<Object?>> driverStream;
  late List<DocumentSnapshot> filteredList;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredList = widget.snapshot.data!.docs;
    driverStream = FirebaseFirestore.instance.collection('drivers').snapshots();
  }

  void filterData(String query) {
    final List<DocumentSnapshot> allDocs = widget.snapshot.data!.docs;
    final List<DocumentSnapshot> filteredDocs = allDocs.where((doc) {
      final Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      final String driverName = data['name'].toString().toUpperCase();
      return driverName.contains(query.toUpperCase());
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
                        filterData(value);
                      });
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
          child: RefreshIndicator(
            key: DriverTile.refreshIndicatorKey2,
            onRefresh: () async {
              setState(() {
                filteredList = widget.snapshot.data!.docs;
              });
            },
            child: ListView.builder(
              // itemCount: widget.snapshot.data!.docs.length,

              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot document = filteredList[index];
                final Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                final String driverName = data['name'].toString().toUpperCase();
                final String driverID = data['id'];
                final String email = data['email'];
                final String phone = data['phone'];
                final String ImageUrl = data['ImageUrl'];
                final String AssignCab = data['AssignCab'];

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
                            setState(() {
                              nextScreen(
                                context,
                                DriverProfile(
                                  DriverName: driverName,
                                  DriverID: driverID,
                                  Email: email,
                                  Phone: phone,
                                  ImageUrl: ImageUrl,
                                  snapshot: widget.snapshot,
                                  AssignCab: AssignCab,
                                ),
                              );
                            });
                          },
                          child: Row(
                            children: [
                              ImageUrl.isEmpty
                                  ? Container(
                                      width: 77,
                                      height: 69,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: Text(
                                          driverName
                                              .substring(0, 1)
                                              .toUpperCase(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  : ImageNetwork(
                                      image: ImageUrl,
                                      borderRadius: BorderRadius.circular(15),
                                      height: 69,
                                      width: 77,
                                      fitWeb: BoxFitWeb.fill,
                                      fitAndroidIos: BoxFit.fill,
                                    ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 8),
                                        child: Text(
                                          driverName,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          driverID,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
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
