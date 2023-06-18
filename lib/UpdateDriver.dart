import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'home.dart';

class UpdateDriverPage extends StatefulWidget {
  const UpdateDriverPage({super.key});

  @override
  State<UpdateDriverPage> createState() => _UpdateDriverPageState();
}

class _UpdateDriverPageState extends State<UpdateDriverPage> {
  Widget custappbar = Text("Update Cabs");
  @override
  Widget build(BuildContext context) {
    String FieldText = '';
    IconData KIconName;
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Driver'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(1000)),
                child: Center(
                    child: Icon(
                  Icons.add_a_photo,
                  color: Colors.white,
                  size: 50,
                )),
              ),
            ),
          ),
          Center(
            child: Text(
              'Update Profile Picture',
              style: TextStyle(fontSize: 15),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 50)),
          KUpdateField(FieldText = 'Driver Name', Icons.person),
          KUpdateField(FieldText = 'Email', KIconName = Icons.email),
          KUpdateField(FieldText = 'Phone', KIconName = Icons.phone),
          KUpdateField(FieldText = 'License Number', KIconName = Icons.badge),
          Padding(padding: EdgeInsets.symmetric(vertical: 40)),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Save',
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
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
          )
        ],
      ),
    );
  }
}
