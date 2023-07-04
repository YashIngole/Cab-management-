import 'package:cab_management/Auth/SignUp.dart';
import 'package:cab_management/Auth/Signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                        child: Text(
                      "WELCOME",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        child: Text(
                      "Add some lines for app",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700], fontSize: 15),
                    )),
                  ],
                ),
                Container(
                    child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      image:
                          DecorationImage(image: AssetImage('assets/car.jpg'))),
                )),
                Column(children: <Widget>[
                  (MaterialButton(
                    minWidth: 25,
                    height: 35,
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Signin()));
                    },
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(5000)),
                    child: Text(
                      "Getstarted",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  )),
                  SizedBox(
                    height: 10,
                  ),
                ])
              ],
            )),
      ),
    );
  }
}
