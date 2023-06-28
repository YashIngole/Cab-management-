import 'package:cab_management/constants.dart';
import 'package:flutter/material.dart';

class UpdateCabPage extends StatefulWidget {
  const UpdateCabPage({super.key});

  @override
  State<UpdateCabPage> createState() => _UpdateCabPageState();
}

class _UpdateCabPageState extends State<UpdateCabPage> {
  
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Cab'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(1000)),
                  child: Center(
                      child: Icon(
                    Icons.add_a_photo,
                    color: Colors.white,
                    size: 50,
                  )),
                ),
              ),
            ),
            Center(
              child: Text(
                'Update Profile Picture',
                style: TextStyle(fontSize: 15),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Assign a driver"),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                  DropdownButton(
                    items: items
                        .map((String item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    hint: Text("Select a item"),
                    value: selectedValue,
                    onChanged: (String? value) {
                      setState(() {
                        selectedValue = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 50)),
            KUpdateField('Cab Name', Icons.local_taxi),
            KUpdateField('Type of vehicle', Icons.directions_car),
            KUpdateField('RTO passing no.', Icons.confirmation_number_sharp),
            //KUpdateField('License Number', Icons.badge),
            Padding(padding: EdgeInsets.symmetric(vertical: 40)),
            ElevatedButton(
              onPressed: () {},
              child: Text(
                'Save',
                
                style: TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }

  Padding KUpdateField(FieldText, KIconName) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Icon(KIconName),
          ),
          Expanded(
            child: TextFormField(
              style: TextStyle(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: FieldText,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
          )
        ],
      ),
    );
  }
}
