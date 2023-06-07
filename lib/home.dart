import 'package:cab_management/constants.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundColor,
      bottomNavigationBar: BottomAppBar(
        elevation: 20,
        height: 70,
        color: Color(0xffFAFAFA),
        child: Container(
          child: Row(
            children: [
              SizedBox(
                width: 40,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.car_rental),
              ),
              SizedBox(
                width: 70,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.person),
              ),
              SizedBox(
                width: 70,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "  Drivers",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 300,
                  height: 40,
                  child: SearchBar(
                    hintText: "Search",
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xff6AEA2E),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
