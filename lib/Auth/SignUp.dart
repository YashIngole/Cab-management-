import 'package:cab_management/Auth/Signin.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:cab_management/Auth/helper.dart';
import 'package:cab_management/Auth/Authentication.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //form key
  final _formKey = GlobalKey<FormState>();

//To take user input
  String email = "";
  String password = "";
  String fullname = "";
  bool _isLoading = false;
  AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Center(
                        child: const Text(
                          'Sign Up.',
                          style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 7, 7, 7),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 5),
                      child: Image.asset("assets/cab22.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3, bottom: 23),
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: 350, maxHeight: 60),
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                            labelStyle: TextStyle(color: Colors.black),
                            hintStyle: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromARGB(255, 110, 109, 109),
                            ),
                            contentPadding: EdgeInsets.all(20),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 104, 104, 105),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 5),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 243, 65, 65),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 5),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          //parameter for name input
                          onChanged: (val) {
                            setState(() {
                              fullname = val;
                              print(fullname);
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
                        constraints:
                            BoxConstraints(maxWidth: 350, maxHeight: 60),
                        child: TextFormField(
                          //parameter for Email input
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
                              color: Color.fromARGB(255, 110, 109, 109),
                            ),
                            contentPadding: EdgeInsets.all(20),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 104, 104, 105),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 5),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 243, 65, 65),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 5),
                                width: 3,
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
                      padding: const EdgeInsets.only(top: 23),
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: 350, maxHeight: 60),
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Create Password',
                            labelStyle: TextStyle(color: Colors.black),
                            hintStyle: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromARGB(255, 110, 109, 109),
                            ),
                            contentPadding: EdgeInsets.all(20),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 104, 104, 105),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 5),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 243, 65, 65),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 0, 0, 5),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          //parameter for password input
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
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 23),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [kGrad1, kGrad2, kGrad3],
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            //Function for saving and validating email and password
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
                            shadowColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text('Already have an Account?'),
                    TextButton(
                      onPressed: () {
                        nextScreen(
                          context,
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Signin(),
                          ),
                        );
                      },
                      child: Text('Sign In.'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await authService
          .registerUserWithEmailAndPassword(fullname, email, password)
          .then((value) async {
        if (value == true) {
          await helperFunctions.saveUserLoggedInStatus(true);
          await helperFunctions.saveUserEmailSF(email);
          await helperFunctions.saveUsernameSF(fullname);

          nextScreenReplace(context, Signin());
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }
}
