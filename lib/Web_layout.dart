import 'package:cab_management/Driver/DriverPage.dart';
import 'package:cab_management/Driver/driverTile.dart';
import 'package:flutter/material.dart';

import 'databaseService.dart';

class Web_layout extends StatefulWidget {
  Web_layout({super.key}) : super(key: key);

  @override
  State<Web_layout> createState() => _Web_layoutState();
  final DatabaseService databaseService = DatabaseService();
}

class _Web_layoutState extends State<Web_layout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [Driver_page(), DriverTile(snapshot: snapshot)],
          ),
        ],
      ),
    );
  }
}
