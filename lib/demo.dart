import 'package:flutter/material.dart';

import 'fetch.dart';
// import "package:"
class Student extends StatefulWidget {
  // const Student({ Key key }) : super(key: key);

  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> {
  /**
   * assume you want to display student id in dropdown button 
   */
  var ids = <DropdownMenuItem<String>>[];
  var initID = 'Select';
  @override
  void initState() {
    getStudData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28.0),
      child: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Student ID: "),
              ),
              Container(
                child: DropdownButton(
                  autofocus: true,
                  items: ids,
                  value: initID,
                  onChanged: (val) {
                    setState(() {
                      initID = val;
                    });
                  },
                ),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {
                print(initID + " is selected");
              },
              child: Text('Print'))
        ],
      ),
    );
  }

  Future getStudData() async {
    var value = await GetFromDB.getStudentDate();
    //
    // print('date of=${PayementState.newDate}');
    for (var data in value) {
      ids.add(DropdownMenuItem<String>(
        child: Text(data['id']),
        value: data['id'],
      ));
    }
  }
}
