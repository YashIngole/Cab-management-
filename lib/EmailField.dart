import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  const EmailField({
    super.key,
  });

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";

  //here are email and password conrtrollers

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 23),
      key: _formKey,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 350, maxHeight: 60),
        child: TextFormField(
          /*validator: (val) {
            return RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(val!)
                ? null
                : "Please enter a valid email";
          },*/
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.black),
            focusColor: Colors.black,
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
          controller: emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please Enter Email';
            } else if (!value.contains('@')) {
              return 'Please Enter Valid Email';
            }
            return null;
          }, //if else statement for email @
        ),
      ),
    );
  }
}
