import 'dart:convert';

import 'package:dabo/utility-lib/HttpRequest.dart';
import 'package:dabo/utility-lib/Utility.dart';
import 'package:flutter/material.dart';

class Employee extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EmployeeState();
  }
}

class EmployeeState extends State<Employee> {
  var _forKey = GlobalKey<FormState>();
  // var _forKey1 = GlobalKey<FormState>();

  String initRole = 'Sales';
  String initEmpID = 'Emp001-MegagaerySales';
  var fullNameController = TextEditingController();
  var salaryController = TextEditingController();
  var workDateController = TextEditingController();
  var editableFullNameController = TextEditingController();
  var EditableSalaryController = TextEditingController();
  var editableWorkDateController = TextEditingController();
  var otherController = TextEditingController();
  String otherID;
  bool isVisible = false;
  String editRole;
  List<DataRow> dataRow = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Employee'),
      ),
      body: ListView(
          padding: const EdgeInsets.all(10.0),
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _forKey,
                  child: Column(
                    // shrinkWrap: true,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            controller: fullNameController,
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please Enter Some value';
                              return null;
                            },
                            onChanged: (val) {},
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Full Name",
                                prefixIcon: Icon(Icons.person_pin)
                                // helperText: 'Full Name Only'
                                ),
                          ))
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
                          ))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: TextFormField(
                              controller: workDateController,
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
                                  labelText: "Work Start Date",
                                  hintText: 'like 20130910',
                                  // helperText: 'Paid Salary ',
                                  prefixIcon: Icon(Icons.work_outline)),
                            ),
                          ))
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Role",
                            style: Utility.textStyle,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownButton<String>(
                            dropdownColor: Colors.lightBlueAccent[400],
                            style: Utility.textStyle,
                            items: [
                              DropdownMenuItem(
                                child: Text('Sales'),
                                value: 'Sales',
                              ),
                              DropdownMenuItem(
                                child: Text('Akeraye'),
                                value: 'Akeraye',
                              ),
                              DropdownMenuItem(
                                child: Text('Eredat'),
                                value: 'Eredat',
                              ),
                              DropdownMenuItem(
                                child: Text('Balemuya'),
                                value: 'Balemuya',
                              ),
                              DropdownMenuItem(
                                child: Text('Transport'),
                                value: 'Transport',
                              )
                            ],
                            value: initRole,
                            onChanged: (String value) {
                              setState(() {
                                initRole = value;
                                // print('Date =$initialPlace');
                              });
                            },
                          )
                        ],
                      ),
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
                            style: Utility.textStyle,
                            // hint: Text('Meshu'),
                            // isDense: true,
                            // isExpanded: true,

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
                              DropdownMenuItem(
                                child: Text('Emp0010-Akeraye4'),
                                value: 'Emp0010-Akeraye4',
                              ),
                              DropdownMenuItem(
                                child: Text('other'),
                                value: 'other',
                              )
                            ],
                            value: initEmpID,
                            onChanged: (String value) {
                              setState(() {
                                if (value == 'other') {
                                  initEmpID = value;
                                  isVisible = true;
                                } else {
                                  isVisible = false;
                                  initEmpID = value;
                                }
                              });
                            },
                          )
                        ],
                      ),
                      Visibility(
                        visible: isVisible,
                        child: TextFormField(
                          controller: otherController,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Please Enter Some value';
                            else if (double.tryParse(value) != null) {
                              return 'Please name od person';
                            }
                            return null;
                          },
                          onChanged: (val) {
                            setState(() {
                              otherID = val;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                // borderRadius: BorderRadius.circular(0.5)
                                ),
                            labelText: "Ether others name",
                            hintText: 'Josi',
                            // helperText: 'Paid Salary ',
                            // prefixIcon: Icon(Icons.people)
                          ),
                        ),
                        // )
                      ),
                      ElevatedButton(
                          // style: StyleMedia.,
                          onPressed: () {
                            if (_forKey.currentState.validate()) {
                              var emp = Map<String, String>();
                              emp = {
                                'fullName': fullNameController.text,
                                'initSalary': salaryController.text,
                                'startDate': workDateController.text,
                                'role': initRole,
                                'empID':
                                    initEmpID == 'other' ? otherID : initEmpID,
                                'action': 'ADD_EMP'
                              };
                              Utility.showAlertDialog(context, "Wait");

                              addEmploye(emp).then((value) {
                                if (value == 'ok') {
                                  initTable();
                                  Navigator.pop(context);
                                  Utility.showSnakBar(
                                      "Done well", context, Colors.greenAccent);
                                  setState(() {
                                    initRole = 'Sales';
                                  });
                                } else {
                                  Utility.showSnakBar(' Error=$value', context,
                                      Colors.redAccent);
                                }
                              });
                            } else {
                              Utility.showSnakBar(
                                  "Please properly fill your form",
                                  context,
                                  Colors.red);
                            }
                          },
                          child: Text('Save')),
                      Divider(
                        thickness: 2,
                      ),
                      Center(
                        child: Text(
                          'List of Employee',
                          style: Utility.textStyle,
                        ),
                      ),
                      Divider(),
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
                            DataColumn(label: Text('Role')),
                            DataColumn(label: Text('Work Start Date')),
                            DataColumn(label: Text('Salary')),
                            DataColumn(
                              label: Text('Delete'),
                            ),
                            DataColumn(
                              label: Text('Edit'),
                            )
                          ],
                          rows: dataRow,
                        ),
                      ),
                      dataRow.length == 0
                          ? LinearProgressIndicator()
                          : Divider()
                    ],
                  )),
            )
          ]),
    );
  }

  void initTable() {
    List<DataRow> _listRow = [];

    getEmp().then((value) {
      var rows = jsonDecode(value) as List;

      for (var row in rows) {
        _listRow.add(DataRow(
            // selected: true,
            cells: [
              DataCell(Text(row['fullName'])),
              DataCell(Text(row['role'])),
              DataCell(Text(row['startDate'])),
              DataCell(Text(row['initSalary'])),
              DataCell(IconButton(
                onPressed: () {
                  deleteEmp(row['empID']);
                },
                icon: Icon(Icons.delete_forever),
                iconSize: 26,
              )),
              DataCell(IconButton(
                onPressed: () {
                  editEmp(row['empID'], row['fullName'], row['initSalary'],
                      row['startDate'], row['role']);
                },
                icon: Icon(Icons.edit),
              ))
            ]));
      }
      setState(() {
        dataRow = _listRow;
      });
    });
  }

  void editEmp(
      String empID, String fullName, String salary, String date, String role) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return DraggableScrollableSheet(
              expand: false,
              //  minChildSize: 0.4,
              initialChildSize: 0.9,
              maxChildSize: 0.9,
              builder: (context, controller) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: editForm(role, fullName, salary, date, empID),
                  ),
                );
              });
        });
  }

  Form editForm(
      String role, String fullName, String salary, String date, String id) {
    editableFullNameController.text = fullName;
    EditableSalaryController.text = salary;
    editableWorkDateController.text = date;
    editRole = role;
    return Form(
        // key: _forKey1,
        child: ListView(
            // shrinkWrap: true,
            children: [
          Row(
            children: [
              Expanded(
                  child: TextFormField(
                controller: editableFullNameController,
                validator: (value) {
                  if (value.isEmpty) return 'Please Enter Some value';
                  return null;
                },
                onChanged: (val) {},
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Full Name",
                    prefixIcon: Icon(Icons.person_pin)
                    // helperText: 'Full Name Only'
                    ),
              ))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: EditableSalaryController,
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
              ))
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  controller: editableWorkDateController,
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
                      labelText: "Work Start Date",
                      hintText: 'like 20130910',
                      // helperText: 'Paid Salary ',
                      prefixIcon: Icon(Icons.work_outline)),
                ),
              ))
            ],
          ),
          Row(
            children: [
              Text(
                "Role",
                style: Utility.textStyle,
              ),
              SizedBox(
                width: 10,
              ),
              DropdownButton<String>(
                dropdownColor: Colors.lightBlueAccent[400],
                style: Utility.textStyle,
                items: [
                  DropdownMenuItem(
                    child: Text('Sales'),
                    value: 'Sales',
                  ),
                  DropdownMenuItem(
                    child: Text('Akeraye'),
                    value: 'Akeraye',
                  ),
                  DropdownMenuItem(
                    child: Text('Eredat'),
                    value: 'Eredat',
                  ),
                  DropdownMenuItem(
                    child: Text('Balemuya'),
                    value: 'Balemuya',
                  ),
                  DropdownMenuItem(
                    child: Text('Transport'),
                    value: 'Transport',
                  )
                ],
                value: editRole,
                onChanged: (String value) {
                  setState(() {
                    editRole = value;
                  });
                },
              )
            ],
          ),
          ElevatedButton(
              // style: StyleMedia.,
              onPressed: () {
                // if (_forKey.currentState.validate()) {
                var emp = Map<String, String>();
                emp = {
                  'fullName': editableFullNameController.text,
                  'initSalary': EditableSalaryController.text,
                  'startDate': editableWorkDateController.text,
                  'role': editRole,
                  'empID': id,
                  'action': 'UPDATE_EMP'
                };
                Utility.showAlertDialog(context, "Wait");
                updateEmploye(emp).then((value) {
                  if (value == 'ok') {
                    initTable();
                    Navigator.pop(context);
                    Utility.showSnakBar(
                        "Done well", context, Colors.greenAccent);
                  } else {
                    Utility.showSnakBar(
                        ' Error=$value', context, Colors.redAccent);
                  }
                });
              },
              child: Text('Update')),
        ]));
  }

  void deleteEmp(String id) {
    showDialog(
        useSafeArea: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
              'Do you want to delete $id?',
              style: Utility.textStyle,
            ),
            title: Text('Delete'),
            actions: [
              // Divider(),
              TextButton(
                  autofocus: true,
                  onPressed: () {
                    Utility.showAlertDialog(context, "Just wait");
                    delEmp(id).then((value) {
                      
                      if (value == 'ok') {
                        setState(() {
                          initTable();
                        });
                        Utility.showSnakBar("Sussfuly Delete Your Employee",
                            context, Colors.greenAccent);
                        Navigator.of(context).pop();
                      } else {
                        Utility.showSnakBar("Successfuly Delete Your Employee",
                            context, Colors.redAccent);
                      }
                    });
                  },
                  child: Text('Yes')),
              TextButton(
                  // autofocus: true,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('No'))
            ],
          );
        });
  }
}
