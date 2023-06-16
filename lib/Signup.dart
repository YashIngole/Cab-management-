import 'package:cab_management/pallete.dart';
import 'package:flutter/material.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Image.asset(''),
        Padding(
          padding: const EdgeInsets.all(150.4),
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
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 350),
          child: TextFormField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(27),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Pallete.borderColor,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(18)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 128, 182, 185),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(18)),
            ),
          ),
        )
      ]),
    ));
  }
}
