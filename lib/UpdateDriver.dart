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
  bool isobsecurePassword = true;
  Icon custicon = Icon(Icons.search);

  Widget custappbar = Text("Update Cabs");
  @override
  Widget build(BuildContext context) {
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
          Padding(
            padding: EdgeInsets.only(top: 50, bottom: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.person),
                ),
                Expanded(
                  child: TextFormField(
                    style: TextStyle(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Driver Name',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.email),
                ),
                Expanded(
                  child: TextFormField(
                    style: TextStyle(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.phone),
                ),
                Expanded(
                  child: TextFormField(
                    style: TextStyle(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Icon(Icons.badge),
                ),
                Expanded(
                  child: TextFormField(
                    style: TextStyle(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'License Number',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
