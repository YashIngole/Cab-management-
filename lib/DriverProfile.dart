import 'package:cab_management/UpdateDriver.dart';
import 'package:cab_management/constants.dart';
import 'package:flutter/material.dart';

class DriverProfile extends StatelessWidget {
  final String DriverName;
  final String DriverID;
  final String Email;
  final String Phone;

  const DriverProfile(
      {super.key,
      required this.DriverName,
      required this.DriverID,
      required this.Email,
      required this.Phone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Driver Profile'),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  nextScreen(context, UpdateDriverPage());
                },
                icon: Icon(Icons.edit)),
            Padding(padding: EdgeInsets.all(5)),
            IconButton(onPressed: () {}, icon: Icon(Icons.delete)),
            Padding(padding: EdgeInsets.all(5)),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      child: Text(
                    DriverName.substring(0, 1).toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  )),
                ),
              ),
            ),
            Center(
              child: Text(
                DriverName,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                  height: 31,
                  width: double.infinity,
                  decoration: BoxDecoration(color: Color(0xffF4F4F4)),
                  child: Center(child: Text("Driver Data:"))),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Driver ID',
                    style: TextStyle(color: Color(0xff959595)),
                  ),
                  Padding(padding: EdgeInsets.all(7)),
                  Text(DriverID,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      )),
                  Padding(padding: EdgeInsets.all(20)),
                  Text('Email', style: TextStyle(color: Color(0xff959595))),
                  Padding(padding: EdgeInsets.all(7)),
                  Text(
                    Email,
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  Padding(padding: EdgeInsets.all(20)),
                  Text('Phone', style: TextStyle(color: Color(0xff959595))),
                  Padding(padding: EdgeInsets.all(7)),
                  Text(
                    Phone,
                    style: TextStyle(fontWeight: FontWeight.w400),
                  ),
                  Padding(padding: EdgeInsets.all(20)),
                ],
              ),
            )
          ],
        ));
  }
}
