import 'dart:typed_data';
import 'package:cab_management/Driver/driverTile.dart';
import 'package:cab_management/constants.dart';
import 'package:cab_management/databaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

Stream? Cabs;
String name = "";
final _formKey = GlobalKey<FormState>();
String id = "";
String email = "";
String phone = "";
String License = "";
String joinning = "";
String? AssignCab;
String ImageUrl = "";

final nameController = TextEditingController();
final emailController = TextEditingController();
final phoneController = TextEditingController();
final licenseController = TextEditingController();
final joinningController = TextEditingController();
//final  _dateController = TextEditingController();

//Dispose Method

@override
void dispose() {
  nameController.text = '';
  emailController.text = '';
  phoneController.text = '';
  licenseController.text = '';
  joinningController.text = '';

  //_dateController.text = '';
}

final DatabaseService databaseService = DatabaseService();
void addNewDriverPopUp(BuildContext context) {
  FirebaseFirestore.instance.collection('Cabs').get().then((querySnapshot) {
    List<String> cabs = []; // Create an empty list to store cab names
    querySnapshot.docs.forEach((doc) {
      var cName = doc.data()['C_name'].toString().toUpperCase();
      var cRTO = doc.data()['C_RTO'].toString().toUpperCase();
      cabs.add(cRTO + " - " + cName);
      print(cabs);
    });
    TextEditingController _date = TextEditingController();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            backgroundColor: kbackgroundColor,
            surfaceTintColor: kbackgroundColor,
            insetPadding: EdgeInsets.all(10),
            contentPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            title: const Text(
              "Add Driver",
              textAlign: TextAlign.center,
            ),
            content: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 1200),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: InkWell(
                                borderRadius: BorderRadius.circular(1000),
                                onTap: () async {
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file = await imagePicker.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  if (file == null) {
                                    return;
                                  }
                                  //convert file to data
                                  final Uint8List fileBytes =
                                      await file.readAsBytes();

                                  // Reference to storage root of Firebase Storage
                                  Reference referenceRoot =
                                      FirebaseStorage.instance.ref();
                                  Reference referenceDirImages =
                                      referenceRoot.child('images');

                                  // Reference for the image to be stored
                                  String uniqueFileName = DateTime.now()
                                          .millisecondsSinceEpoch
                                          .toString() +
                                      '.jpg';
                                  Reference referenceImageToUpload =
                                      referenceDirImages.child(uniqueFileName);
                                  try {
                                    // Store the file
                                    await referenceImageToUpload.putData(
                                        fileBytes,
                                        SettableMetadata(
                                            contentType: 'image/jpeg'));
                                    ImageUrl = await referenceImageToUpload
                                        .getDownloadURL();
                                    print(ImageUrl);
                                    setState(
                                      () {
                                        ImageUrl;
                                      },
                                    );
                                  } catch (e) {
                                    print('Error uploading image: $e');
                                  }
                                },
                                child: ImageUrl.isEmpty
                                    ? Container(
                                        height: 150,
                                        width: 150,
                                        decoration: BoxDecoration(
                                          color: kImgColor,
                                          borderRadius:
                                              BorderRadius.circular(1000),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.add_a_photo,
                                            color: Colors.white,
                                            size: 50,
                                          ),
                                        ),
                                      )
                                    : ImageNetwork(
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        image: ImageUrl,
                                        height: 150,
                                        width: 150)),
                          ),
                        ),
                        Center(
                          child: Text(
                            'Upload Profile Picture',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 50)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: DropdownButtonFormField<String>(
                            isExpanded: true,
                            decoration: InputDecoration(
                                constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width * 0.5,
                            )),
                            items: cabs.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              );
                            }).toList(),
                            hint: Text("Assign a Cab"),
                            onChanged: (String? value) {
                              setState(() {
                                AssignCab = value;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.person),
                              ),
                              Expanded(
                                child: TextFormField(
                                  onChanged: (val) {
                                    setState(() {
                                      name = val.toLowerCase();
                                    });
                                  },
                                  style: TextStyle(),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 243, 65, 65),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 0, 5),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    labelText: 'Name',
                                  ),
                                  controller: nameController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter Name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.email),
                              ),
                              Expanded(
                                child: TextFormField(
                                  // validator: (val) {
                                  //   return RegExp(
                                  //               r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  //           .hasMatch(val!)
                                  //       ? null
                                  //       : "Please enter a valid email";
                                  // },
                                  onChanged: (val) {
                                    setState(() {
                                      email = val;
                                    });
                                  },
                                  style: TextStyle(),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 243, 65, 65),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 0, 5),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    labelText: 'Email ',
                                  ),
                                  controller: emailController,
                                  validator: (value) {
                                    return RegExp(
                                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                            .hasMatch(value!)
                                        ? null
                                        : "Please enter a valid email";
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.phone),
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (phone.length < 10) {
                                      return 'Phone must be atleast 10 digits';
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      phone = val;
                                    });
                                  },
                                  style: TextStyle(),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 243, 65, 65),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 0, 5),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    labelText: 'Phone',
                                  ),
                                  controller: phoneController,

                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return "Please Enter a Phone Number";
                                  //   } else if (!RegExp(
                                  //           r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$')
                                  //       .hasMatch(value)) {
                                  //     return "Please Enter a Valid Phone Number";
                                  //   }
                                  // },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.document_scanner),
                              ),
                              Expanded(
                                child: TextFormField(
                                  onChanged: (val) {
                                    setState(() {
                                      License = val.toUpperCase();
                                    });
                                  },
                                  style: TextStyle(),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 243, 65, 65),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 0, 5),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    labelText: 'License Number',
                                  ),
                                  controller: licenseController,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please Enter License';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                              )
                            ],
                          ),
                        ),

                        // Datetime _dateTime = DateTime.now();
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(Icons.date_range),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: _date,
                                  onChanged: (val) {
                                    setState(() {
                                      joinning = val;
                                    });
                                  },
                                  style: TextStyle(),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color.fromARGB(255, 243, 65, 65),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 0, 0, 5),
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    labelText: 'Joining Date',
                                  ),
                                  onTap: () async {
                                    DateTime? pickdate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2025),
                                    );
                                    if (pickdate != null) {
                                      setState(() {
                                        _date.text = DateFormat('yyyy-MM-dd')
                                            .format(pickdate);
                                      });
                                    }
                                    ;
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  setState(
                    () {
                      ImageUrl = '';
                    },
                  );
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                child: const Text(
                  "CANCEL",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(
                    () {
                      joinning = _date.text;
                    },
                  );
                  if (_formKey.currentState!.validate()) {
                    setState(
                      () {
                        name = nameController.text;
                        email = emailController.text;
                        phone = phoneController.text;
                        License = licenseController.text;
                        //joinning = joinningController.text;
                      },
                    );
                  } else
                    return null;
                  await databaseService.saveDriverData(
                      name.toUpperCase(),
                      id.toUpperCase(),
                      email,
                      phone,
                      License,
                      joinning,
                      ImageUrl,
                      AssignCab == null
                          ? AssignCab = "Not selected "
                          : AssignCab);
                  DriverTile.refreshIndicatorKey2.currentState?.show();
                  Navigator.of(context).pop();
                  dispose();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Center(
                        child: Text('Driver Registered Successfully'),
                      ),
                    ),
                  );
                  setState(
                    () {
                      ImageUrl = '';
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          );
        });
      },
    );
  }).catchError((error) {
    // Handle any potential errors here
    print('Error fetching cabs: $error');
  });
}
