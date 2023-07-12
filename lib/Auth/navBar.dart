import 'package:cab_management/Auth/Signin.dart';
import 'package:cab_management/Driver/addNewDriverPopUp.dart';
import 'package:cab_management/constants.dart';
import 'package:flutter/material.dart';
//import 'package:cab_management/Auth/DBservice.dart';
import 'package:cab_management/Auth/Authentication.dart';
import 'package:cab_management/Auth/helper.dart';

class navBar extends StatefulWidget {
  const navBar({super.key});

  @override
  State<navBar> createState() => _navBarState();
}

class _navBarState extends State<navBar> {
  String userName = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  gettingUserData() async {
    await helperFunctions.getUserEmailFromSF().then((value) {
      setState(() {
        email = value!;
      });
    });
    await helperFunctions.getUserNameFromSF().then((val) {
      setState(() {
        userName = val!;
      });
    });
  }

  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      shadowColor: kbackgroundColor,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: kSearchbarColor,
                child: Center(
                  child: Icon(
                    Icons.person,
                    size: 60,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(userName),
            ),
          ),
          Center(
            child: Text(email),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'Logout',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
            ),
            onTap: () {
              authService.signOut().whenComplete(() {
                nextScreenReplace(context, const Signin());
              });
            },
          ),
        ],
      ),
    );
  }
}
