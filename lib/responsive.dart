import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget Mobile;
  final Widget Desktop;
  const Responsive({Key? key, required this.Mobile, required this.Desktop});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1000) {
          return Desktop;
        }
        return Mobile;
      },
    );
  }
}
