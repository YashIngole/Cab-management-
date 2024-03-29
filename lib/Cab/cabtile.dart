import 'dart:convert';
import 'dart:io';

import 'package:cab_management/Cab/Cabprofile.dart';
import 'package:cab_management/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class cabtile extends StatefulWidget {
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  static GlobalKey<_cabTileState> cabkey = GlobalKey<_cabTileState>();
  static GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  cabtile({Key? key, required this.snapshot}) : super(key: key);

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
          padding: const EdgeInsets.only(left: 7, right: 10, bottom: 30),
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: kSearchbarColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 5),
                  child: Icon(
                    Icons.search_sharp,
                    color: Colors.black,
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
                      hintText: 'Search Cabs',
                      hintStyle: TextStyle(color: Colors.black45),
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
            key: cabtile.refreshIndicatorKey,
            onRefresh: () async {
              setState(() {
                filteredList = widget.snapshot.data!.docs;
              });
            },
            child: ListView.builder(
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
                final String AssignDriver = data['AssignDriver'];

                return Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 0, bottom: 10),
                        child: InkWell(
                          onTap: () {
                            nextScreen(
                              context,
                              CabProfile(
                                C_name: C_name,
                                C_id: C_id,
                                C_type: C_type,
                                C_RTO: C_RTO,
                                ImageUrl: ImageUrl,
                                snapshot: widget.snapshot,
                                AssignDriver: AssignDriver,
                              ),
                            );
                          },
                          child: Row(
                            children: [
                              ImageUrl.isEmpty
                                  ? Container(
                                      width: 70,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: kImgColor,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Center(
                                        child: Text(
                                          C_name.substring(0, 1).toUpperCase(),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    )
                                  : defaultTargetPlatform ==
                                          TargetPlatform.android
                                      ? CachedNetworkImage(
                                          height: 60,
                                          width: 70,
                                          imageUrl: ImageUrl,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                        )
                                      : ImageNetwork(
                                          image: ImageUrl,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          height: 60,
                                          width: 70,
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
                                          C_name,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          C_id,
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black38),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8, left: 8, right: 8),
                                        child: Divider(
                                          color: Colors.black,
                                          thickness: 0.1,
                                          height: 0.6,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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
