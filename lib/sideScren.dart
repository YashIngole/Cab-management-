import 'package:flutter/material.dart';

class SideScreenDesktop extends StatefulWidget {
  static GlobalKey<_SideScreenDesktopState> sidescreenkey =
      GlobalKey<_SideScreenDesktopState>();

  SideScreenDesktop({
    super.key,
  });

  @override
  State<SideScreenDesktop> createState() => _SideScreenDesktopState();
}

class _SideScreenDesktopState extends State<SideScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      key: SideScreenDesktop.sidescreenkey,
      color: Colors.greenAccent,
    );
  }
}