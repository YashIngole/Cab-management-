import 'package:flutter/material.dart';

class cabPage extends StatefulWidget {
  @override
  State<cabPage> createState() => _cabPageState();
}

class _cabPageState extends State<cabPage> {
  // const cabPage({super.key});
  Icon custicon = Icon(Icons.search);

  Widget custappbar = Text("Cabs");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green[300],
          actions: <Widget>[
            IconButton(
              onPressed: () {
                //showSearch(context: context, delegate: delegate)
              },
              icon: custicon,
            ),
          ],
          elevation: 20.0,
          title: custappbar,
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 100,
                width: 200,
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                width: 200,
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                width: 200,
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 100,
                width: 200,
                color: Colors.grey,
              )
            ],
          ),
        ));
  }
}
