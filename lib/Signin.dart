import 'package:cab_management/SignUp.dart';
import 'package:cab_management/constants.dart';
import 'package:cab_management/home.dart';
import 'package:cab_management/pallete.dart';
import 'package:flutter/material.dart';

import 'EmailField.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";

  //here are email and password conrtrollers

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  userLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => home()));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      key: _formKey,
      child: Column(children: [
        Image.asset(''),
        Padding(
          padding: const EdgeInsets.only(top: 250),
          child: Center(
            child: const Text(
              'Sign in.',
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 7, 7, 7)),
            ),
          ),
        ),
        EmailField(),
        Padding(
          padding: const EdgeInsets.only(top: 23),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 350, maxHeight: 60),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(
                    fontSize: 20.0, color: Color.fromARGB(255, 110, 109, 109)),
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
              controller: passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Enter Password';
                }
                return null;
              },
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
                //validates password and email

                if (_formKey.currentState!.validate()) {
                  setState(() {
                    email = emailController.text;
                    password = passwordController.text;
                  });

                  userLogin();
                }
              },
              child: Text(
                'Sign in',
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
        Padding(
          padding: const EdgeInsets.only(top: 27),
          child: Text("Don't have an Account? ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              )),
        ),
        TextButton(
            onPressed: () {
              nextScreen(context, LoginPage());
            },
            child: Text('Sign up.'))
      ]),
    ));
  }
}
