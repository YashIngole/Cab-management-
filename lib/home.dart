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
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 30, bottom: 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "  Drivers",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35, right: 9),
              child: Row(
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
                    width: 13,
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 2.0,
                            offset: Offset(0.0, 1.5))
                      ],
                      borderRadius: BorderRadius.circular(12),
                      color: Color(0xff6AEA2E),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.search_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 42, right: 12, top: 43),
              child: Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30)),
                  color: Colors.white,
                ),
                height: 600,
                width: double.maxFinite,
                child: SafeArea(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          height: 32,
                          width: 110,
                          decoration: BoxDecoration(
                              color: Color(0xffFBE0E0),
                              borderRadius: BorderRadius.circular(7)),
                          child: Center(
                            child: Text(
                              "Add New Driver",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
              )),
            ),
          ],
        )),
      ),
    );
  }
}
