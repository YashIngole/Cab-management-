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
          // decoration: const BoxDecoration(
          //   image: DecorationImage(image: AssetImage("assets/welcomebackground.png"),
          //   fit : BoxFit.fill
          //  ), ),
          
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
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
                          
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        child: Text(
                      "Bug aisa banao ki 4 logo ko feature lagay",
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
                          DecorationImage(image: AssetImage('assets/front_image.png'))),
                )),
                Column(children: <Widget>[
                  (MaterialButton(
                    minWidth: 80,
                    height: 40,
                    color: Color.fromARGB(255, 218, 234, 247),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Signin()));
                    },
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(5000)),
                    child: Text(
                      "Get started",
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
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
