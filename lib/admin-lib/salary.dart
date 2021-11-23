import 'dart:convert';

import 'package:abushakir/abushakir.dart';
import 'package:dabo/utility-lib/HttpRequest.dart';
import 'package:dabo/utility-lib/Utility.dart';
import 'package:flutter/material.dart';

class Salary extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SalaryState();
  }
}

class SalaryState extends State<Salary> {
  var _forKey = GlobalKey<FormState>();
  String initEmpID = 'Emp004-Eredat';
  var salaryController = TextEditingController();
  var salaryDateController = TextEditingController();
  List<DataRow> dataRow = [];
  var totalExp = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTable();
  }

  @override
  Widget build(BuildContext context) {
    String result = '';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Employee Salary'),
        automaticallyImplyLeading: true,
      ),
      body: Form(
        key: _forKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Row(
                children: [
                  Text(
                    "EmpID",
                    style: Utility.textStyle,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  DropdownButton<String>(
                    dropdownColor: Colors.lightBlueAccent[400],
                    style:
                        TextStyle(color: Colors.deepPurpleAccent, fontSize: 16),
                    items: [
                      DropdownMenuItem(
                        child: Text('Emp001-MegagaerySales'),
                        value: 'Emp001-MegagaerySales',
                      ),
                      DropdownMenuItem(
                        child: Text('Emp002-SaveSales'),
                        value: 'Emp002-SaveSales',
                      ),
                      DropdownMenuItem(
                        child: Text('Emp003-GumataSales'),
                        value: 'Emp003-GumataSales',
                      ),
                      DropdownMenuItem(
                        child: Text('Emp004-Eredat'),
                        value: 'Emp004-Eredat',
                      ),
                      DropdownMenuItem(
                        child: Text('Emp005-Balemuya'),
                        value: 'Emp005-Balemuya',
                      ),
                      DropdownMenuItem(
                        child: Text('Emp006-Transport'),
                        value: 'Emp006-Transport',
                      ),
                      DropdownMenuItem(
                        child: Text('Emp007-Akeraye1'),
                        value: 'Emp007-Akeraye1',
                      ),
                      DropdownMenuItem(
                        child: Text('Emp008-Akeraye2'),
                        value: 'Emp008-Akeraye2',
                      ),
                      DropdownMenuItem(
                        child: Text('Emp009-Akeraye3'),
                        value: 'Emp009-Akeraye3',
                      ),

                      //
                      DropdownMenuItem(
                        child: Text('Emp0010-Akeraye4'),
                        value: 'Emp0010-Akeraye4',
                      ),
                      DropdownMenuItem(
                        child: Text('Beza123'),
                        value: 'Beza123',
                      ),
                      DropdownMenuItem(
                        child: Text('kale123'),
                        value: 'kale123',
                      ),
                      DropdownMenuItem(
                        child: Text('meshu123'),
                        value: 'meshu123',
                      ),
                      DropdownMenuItem(
                        child: Text('Sol123'),
                        value: 'Sol123',
                      )
                    ],
                    value: initEmpID,
                    onChanged: (String value) {
                      setState(() {
                        initEmpID = value;
                        // print('Date =$initialPlace');
                      });
                    },
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: salaryController,
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Please Enter Some value';
                        else if (double.tryParse(value) == null) {
                          return 'Please Enter number only';
                        }
                        return null;
                      },
                      onChanged: (val) {},
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.5)),
                          labelText: "Salary",
                          // helperText: 'Paid Salary ',
                          prefixIcon: Icon(Icons.money)),
                    ),
                  )),
                  Text(result)
                ],
              ),
              TextFormField(
                controller: salaryDateController,
                validator: (value) {
                  if (value.isEmpty)
                    return 'Please Enter Some value';
                  else if (double.tryParse(value) == null) {
                    return 'Please Enter like 20130910';
                  }
                  return null;
                },
                onChanged: (val) {},
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.5)),
                    labelText: "Salary Date",
                    hintText: 'like 20130910',
                    // helperText: 'Paid Salary ',
                    prefixIcon: Icon(Icons.work_outline)),
              ),
              ElevatedButton(
                  // style: StyleMedia.,
                  onPressed: () {
                    if (_forKey.currentState.validate()) {
                      var emp = Map<String, String>();
                      var today = EtDatetime.now().toString();
                      emp['today'] = today;
                      emp = {
                        'initSalary': salaryController.text,
                        'startDate': salaryDateController.text,
                        'empID': initEmpID,
                        'action': 'PAY_SALARY'
                      };
                      Utility.showAlertDialog(context, "Wait");

                      paySalary(emp).then((value) {
                        if (value == 'ok') {
                          Navigator.pop(context);
                          Utility.showSnakBar(
                              "Done well", context, Colors.greenAccent);
                          initTable();
                        } else {
                          Utility.showSnakBar(
                              ' Error=$value', context, Colors.redAccent);
                        }
                      });
                    } else {
                      Utility.showSnakBar("Please properly fill your form",
                          context, Colors.red);
                    }
                  },
                  child: Text('Pay')),
              Divider(),
              Center(
                child: Text(
                  'List of Employee Salary',
                  style: Utility.textStyle,
                ),
              ),
              Divider(),
              totalExp != 0.0 ? Text("Monthly Expeness =$totalExp") : Text(""),
              totalExp != 0.0
                  ? Text("Dayliy Expeness =${totalExp / 30}")
                  : Text(""),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(10),
                child: DataTable(
                    showCheckboxColumn: true,
                    sortColumnIndex: 0,
                    // headingRowColor: Color,
                    showBottomBorder: true,
                    // headingRowColor: Theme.of(context).primaryColorDark.withOpacity(0.5),
                    columns: [
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Remining Date')),
                      DataColumn(label: Text('Salary')),
                      DataColumn(
                        label: Text('Delete'),
                      ),
                      DataColumn(
                        label: Text('Edit'),
                      )
                    ],
                    rows: dataRow),
              ),
              dataRow.length == 0 ? LinearProgressIndicator() : Divider()
            ],
          ),
        ),
      ),
    );
  }

  void initTable() {
    List<DataRow> _listRow = [];
    var today = EtDatetime.now();
    var total = 0.0;
// var lastDaye=EtDatetime.parse("2013")
    getSalary().then((value) {
      var rows = jsonDecode(value) as List;
      for (var row in rows) {
        // var lastDate = EtDatetime.parse(row['salaryDate']);
        var val =
            30 - (today.difference(EtDatetime.parse(row['salaryDate'])).inDays);
        MaterialStateProperty<Color> colors;
        total = total + double.parse(row['initSalary']);
        if (val < 0) {
          colors =
              MaterialStateProperty.resolveWith((states) => Colors.redAccent);
        } else if (val <= 5) {
          colors = MaterialStateProperty.resolveWith(
              (states) => Colors.yellowAccent);
        } else {
          colors =
              MaterialStateProperty.resolveWith((states) => Colors.greenAccent);
        }
        _listRow.add(DataRow(color: colors, cells: [
          DataCell(Text(row['fullName'])),
          DataCell(Text(
              '${30 - today.difference(EtDatetime.parse(row['salaryDate'])).inDays} Days left for salary')),
          DataCell(Text(row['initSalary'])),
          DataCell(IconButton(
            onPressed: () {
              // deleteEmp(row['empID']);
            },
            icon: Icon(Icons.delete_forever),
            iconSize: 26,
          )),
          DataCell(IconButton(
            onPressed: () {
              // editEmp(row['empID'], row['fullName'], row['initSalary'],
              //     row['startDate'], row['role']);
            },
            icon: Icon(Icons.edit),
          ))
        ]));
      }
      setState(() {
        dataRow = _listRow;
        totalExp = total;
        null;
      });
    });
  }
}



// Java Code for Linked List Implementation



