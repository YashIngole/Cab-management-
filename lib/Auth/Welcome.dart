import 'package:cab_management/Auth/SignUp.dart';
import "package:flutter/material.dart";
import 'package:rive/rive.dart';

import '../constants.dart';
import 'Signin.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 132, 130, 252),
      backgroundColor: Color(0xffECECEC),

      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 100, right: 100, top: 50),
                child: Container(
                    color: Colors.transparent,
                    child: Image.asset("assets/welcome.png")),
              ),
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              width: 400,
              height: 400,
              child: RiveAnimation.asset("assets/vehicle_loader.riv"),
            ),
            Text(
              "Let's Get \n Started!",
              style: TextStyle(
                fontSize: 27,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Container(
                alignment: Alignment.bottomCenter,
                height: 40,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: kGrad1),
                child: ElevatedButton(
                  onPressed: () {
                    nextScreen(context, LoginPage());
                  },
                  child: Text(
                    'Sign Up',
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
            ),
            SizedBox(height: 20),
            Text('Already have an Account?'),
            TextButton(
              onPressed: () {
                nextScreen(context, Signin());
              },
              child: Text(
                'Sign In.',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
