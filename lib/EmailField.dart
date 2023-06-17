import 'package:flutter/material.dart';

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.45),
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
                fontSize: 20.0, color: Color.fromARGB(255, 110, 109, 109)),
            contentPadding: EdgeInsets.all(20),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 104, 104, 105),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(18)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 0, 0, 5),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(18)),
          ),
        ),
      ),
    );
  }
}
