import 'package:cab_management/constants.dart';
import 'package:cab_management/firebase_options.dart';
import 'package:cab_management/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cab_management/Cab/database_c.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

final CollectionReference Cabs =
    FirebaseFirestore.instance.collection('Cabs');

final Database_c database_c = Database_c();

void updateCabData() async {
  try {
    QuerySnapshot querySnapshot = await Cabs
        .where('C_name', isEqualTo: 'C_name')
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      String documentId = querySnapshot.docs[0].id;

      await Cabs.doc(documentId).update({
        'C_name': 'C_name',
        'C_type': 'C_type',
        'C_RTO': 'C_RTO',
        // Add more fields and their updated values
      });

    }
  } catch (e) {
    print('Error updating cab data: $e');
  }
}

class UpdateCabPage extends StatefulWidget {
  const UpdateCabPage({Key? key}) : super(key: key);

  @override
  State<UpdateCabPage> createState() => _UpdateCabPageState();
}

class _UpdateCabPageState extends State<UpdateCabPage> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Cab'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(1000),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                'Update Profile Picture',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Assign a driver"),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                  DropdownButton(
                    items: items
                        .map(
                          (String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    hint: Text("Select a item"),
                    value: selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 50)),
            KUpdateField('Cab Name', Icons.local_taxi),
            KUpdateField('Cab Type', Icons.directions_car),
            KUpdateField('RTO passing no.', Icons.confirmation_number_sharp),
            //KUpdateField('License Number', Icons.badge),
            Padding(padding: EdgeInsets.symmetric(vertical: 40)),
            ElevatedButton(
              onPressed: () {
                updateCabData();
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding KUpdateField(FieldText, KIconName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(KIconName),
          ),
          Expanded(
            child: TextFormField(
              style: TextStyle(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: FieldText,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
        ],
      ),
    );
  }
}
