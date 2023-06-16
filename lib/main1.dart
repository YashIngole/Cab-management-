import 'package:flutter/material.dart';

class main1 extends StatelessWidget {
  const main1({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 50,
              width: 50,
              color: Colors.black,
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.purple,
        title: Text(
          "main1",
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green,
      ),
    );
  }
}
