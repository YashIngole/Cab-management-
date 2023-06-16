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
          padding: const EdgeInsets.all(120.0),
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
        Padding(
          padding: const EdgeInsets.all(0.45),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 350, maxHeight: 60),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Email',
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
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 350, maxHeight: 60),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Password',
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
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Pallete.gradient1,
                  Pallete.gradient2,
                  Pallete.gradient3
                ],
              ),
              borderRadius: BorderRadius.circular(18)),
          child: ElevatedButton(
            onPressed: () {},
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
      ]),
    ));
  }
}
