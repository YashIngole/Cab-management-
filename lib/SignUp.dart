import 'package:cab_management/Signin.dart';
import 'package:cab_management/home.dart';
import 'package:cab_management/pallete.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:cab_management/helper.dart';
import 'package:cab_management/Authentication.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String Password = "";
  String Fullname = "";
  bool _isLoading = false;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              key: _formKey,
              child: Column(children: [
                //Image.asset(""),
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
                      onChanged: (val) {
                        setState(() {
                          Fullname = val;
                          print(Fullname);
                        });
                      },
                      validator: (val) {
                        if (val!.isNotEmpty) {
                          return null;
                        } else {
                          return "Name cannot be empty";
                        }
                      },
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
                      onChanged: (val) {
                        setState(() {
                          email = val;
                          print(email);
                        });
                      },
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

                      //validation of password
                      validator: (val) {
                        if (val!.length < 6) {
                          return "Password must be at least 6 characters";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) {
                        setState(() {
                          Password = val;
                          print(Password);
                        });
                      },
                    ),
                  ),
                ),
                /* Padding(
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
                ),*/
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
                        //Validating password and email by register button
                        register();
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
                TextButton(
                    onPressed: () {
                      nextScreen(
                          context,
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Signin(),
                          ));
                    },
                    child: Text('Sign In.'))
              ]),
            ),
    );
  }

  register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailAndPassword(Fullname, email, Password)
          .then((value) async {
        if (value == true) {
          //saving the shared preferences state
          await helperFunctions.saveUserLoggedInStatus(true);
          await helperFunctions.saveUserEmailSF(email);
          await helperFunctions.saveUsernameSF(Fullname);

          nextScreenReplace(context, const home());
        } else {
          _isLoading = false;
        }
      });
    }
  }
}
