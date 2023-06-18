import 'package:cab_management/Signin.dart';
import 'package:cab_management/pallete.dart';
import 'package:flutter/material.dart';

import 'EmailField.dart';
import 'constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          Image.asset(''),
          Padding(
            padding: const EdgeInsets.only(top: 250),
            child: Center(
              child: const Text(
                'Sign Up.',
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 7, 7, 7)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 350, maxHeight: 60),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 110, 109, 109)),
                  contentPadding: EdgeInsets.all(20),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 104, 104, 105),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 5),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 350, maxHeight: 60),
              child: TextFormField(
                validator: (val) {
                  return RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(val!)
                      ? null
                      : "Please enter a valid email";
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.black),
                  focusColor: Colors.black,
                  hintStyle: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 110, 109, 109)),
                  contentPadding: EdgeInsets.all(20),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 104, 104, 105),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 5),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 23),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 350, maxHeight: 60),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Create Password',
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 110, 109, 109)),
                  contentPadding: EdgeInsets.all(20),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 104, 104, 105),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 5),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 23),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 350, maxHeight: 60),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  labelStyle: TextStyle(color: Colors.black),
                  hintStyle: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 110, 109, 109)),
                  contentPadding: EdgeInsets.all(20),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 104, 104, 105),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 0, 0, 5),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 23),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Pallete.gradient1,
                      Pallete.gradient2,
                      Pallete.gradient3
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12)),
              child: ElevatedButton(
                onPressed: () {
                  nextScreen(context, Signin());
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(350, 50),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
