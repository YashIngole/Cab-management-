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
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.car_rental),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.person),
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.settings),
                ),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                    height: 50,
                    child: SearchBar(
                      hintText: "Search",
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 4.0,
                          offset: Offset(0.0, 4))
                    ],
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 163, 251, 122),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
