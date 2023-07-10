import 'package:cab_management/Auth/SignUp.dart';
import "package:flutter/material.dart";
import 'package:rive/rive.dart';

import '../constants.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomrState();
}

class _WelcomrState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 132, 130, 252),
      backgroundColor: Color(0xffECECEC),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 5),
            child: Stack(
              children: [
                Image.asset('assets/location.png'),
                Image.asset("assets/welcome.png")
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Container(
              alignment: Alignment.topCenter,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: RiveAnimation.asset("assets/vehicle_loader.riv"),
            ),
          ),
          Text(
            "Let's Get \n Started!",
            style: TextStyle(
              fontSize: 27,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 120),
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 40,
              width: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color(0xff9E9E9E)),
              child: ElevatedButton(
                onPressed: () {
                  nextScreen(context, LoginPage());
                },
                child: Text(
                  'SignUp',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(350, 50),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
