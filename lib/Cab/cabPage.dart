import 'package:flutter/material.dart';
import 'database_c.dart';

class cabPage extends StatefulWidget {
  @override
  State<cabPage> createState() => _cabPageState();
}

class _cabPageState extends State<cabPage> {
  String C_name = "";
  String C_id = "";
  String C_type = "";
  String C_RTO = "";
  final Database_c database_c = Database_c();
  Stream? Cabs;
  String ImageUrl = "";

  late PageController _myPage;
  var selectedPage;
  String inputValue = '';

  @override
  void initState() {
    super.initState();
    _myPage = PageController(initialPage: 0);
    selectedPage = 0;
  }
  void _onItemTapped(int index) {
    setState(() {
      selectedPage = index;
      _myPage.animateToPage(index,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNewCabPopUp(context);
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
  addNewCabPopUp(BuildContext context  ){
    showDialog(context: context, builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: const Text(
              "Add Cab",
              textAlign: TextAlign.center,
            ),
        );
      });
    });
  }
  addNewDriverPopUp(BuildContext context  ){
    showDialog(context: context, builder: (context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: const Text(
              "Add Driver",
              textAlign: TextAlign.center,
            ),
        );
      });
    });
  }
}
