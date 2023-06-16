import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[330],
        body: SafeArea(
          child: Center(
              child: Column(children: [
            SizedBox(height: 40),
            Icon(
              Icons.lock,
              size: 100,
            ),
            SizedBox(height: 30),
            //welcome
            Text(
              'Welcome to Caby',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 20),
          ])),
        ));
  }
}
