import 'package:cab_management/Auth/Signin.dart';
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
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                color: Color.fromARGB(235, 54, 132, 235),
                image: DecorationImage(image: AssetImage('assets/taxi.avif'))),
            accountName: Text(
              userName,
              style: TextStyle(color: Color.fromARGB(255, 251, 252, 250)),
            ),
            accountEmail: Text(
              email,
              style: TextStyle(color: Color.fromARGB(255, 251, 252, 250)),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Material(
                  color: Color.fromARGB(255, 57, 134, 223),
                  child: InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 70,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text(
              'Signout',
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
