import 'package:cab_management/Auth/SignUp.dart';
import 'package:cab_management/constants.dart';
import 'package:cab_management/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cab_management/Auth/Authentication.dart';
import 'package:cab_management/Auth/DBservice.dart';
import 'package:cab_management/Auth/helper.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  bool _isLoading = false;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kbackgroundColor,
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                key: _formKey,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 45,
                            fontWeight: FontWeight.w700,
                            color: Color.fromARGB(255, 7, 7, 7)),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 20)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 500),
                        child: Image.asset("assets/taxi22.png")),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 80, left: 20, right: 20),
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
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight:
                                FontWeight.bold, // Add font weight for emphasis
                          ),
                          hintText: 'Enter your email', // Add a hint text
                          hintStyle: TextStyle(
                            fontSize: 16.0,
                            color: Color.fromARGB(255, 110, 109, 109),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 20),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors
                                  .grey.shade400, // Use a lighter border color
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors
                                  .black, // Use a different color for focused border
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors
                                  .red, // Use a different color for error border
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors
                                  .blue, // Use a different color for focused error border
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
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
                    padding:
                        const EdgeInsets.only(top: 23, left: 20, right: 20),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 350, maxHeight: 60),
                      child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight
                                  .bold, // Add font weight for emphasis
                            ),
                            hintText: 'Enter your Password', // Add a hint text
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: Color.fromARGB(255, 110, 109, 109),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 20),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey
                                    .shade400, // Use a lighter border color
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .black, // Use a different color for focused border
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors
                                    .red, // Use a different color for error border
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .blue, // Use a different color for focused error border
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          validator: (val) {
                            if (val!.length < 6) {
                              return "Password must be at least 6 characters";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (val) {
                            setState(() {
                              password = val;
                              print(password);
                            });
                          }),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 30, left: 20, right: 20),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [kGrad1, kGrad2, kGrad3],
                          ),
                          borderRadius: BorderRadius.circular(12)),
                      child: ElevatedButton(
                        onPressed: () {
                          sign_in();
                          //validates password and email
                        },
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
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
                      child: Text(
                        'Sign up.',
                        style: TextStyle(color: Colors.green),
                      ))
                ]), //column
              ))); //form, Singlechildscrollview, Scaffold
  }

  sign_in() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .loginWithEmailAndPassword(email, password)
          .then((value) async {
        if (value == true) {
          QuerySnapshot snapshot =
              await databaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                  .gettingUserData(email);

          //saving the values to our shared preferences

          await helperFunctions.saveUserLoggedInStatus(true);
          await helperFunctions.saveUserEmailSF(email);
          await helperFunctions.saveUsernameSF(snapshot.docs[0]['fullName']);

          nextScreenReplace(context, Home());
        } else {
          _isLoading = false;
        }
      });
    }
  }
}
