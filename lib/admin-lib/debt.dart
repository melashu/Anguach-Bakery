import 'dart:convert';

import 'package:abushakir/abushakir.dart';
import 'package:dabo/utility-lib/HttpRequest.dart';
import 'package:dabo/utility-lib/Utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Debt extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DebtState();
  }
}

class DebtState extends State<Debt> {
  var _forKey = GlobalKey<FormState>();
  // var _forKey1 = GlobalKey<FormState>();

  String initReason = 'ተበዳሪ';
  String initEmpID = 'Emp001-MegagaerySales';
  String status = 'open';
  var amountController = TextEditingController();
  var otherController = TextEditingController();
  var isVisible = false;
  var otherID;
  List<DataRow> listRow = [];

  var salaryController = TextEditingController();
  // var workDateController = TextEditingController();
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
        title: Text('Register Debt Related Issues'),
      ),
      body: ListView(padding: const EdgeInsets.all(10.0), children: [
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
                          child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          controller: amountController,
                          validator: (value) {
                            if (value.isEmpty)
                              return 'Please Enter Some value';
                            else if (double.tryParse(value) == null) {
                              return 'Please Enter like 200 birr';
                            }
                            return null;
                          },
                          onChanged: (val) {},
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(0.5)),
                              labelText: "Enter Birr",
                              hintText: 'like 200',
                              // helperText: 'Paid Salary ',
                              prefixIcon: Icon(Icons.work_outline)),
                        ),
                      ))
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "Reason",
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
                            child: Text('ተበዳሪ'),
                            value: 'ተበዳሪ',
                          ),
                          DropdownMenuItem(
                            child: Text('አበዳሪ'),
                            value: 'አበዳሪ',
                          ),
                          DropdownMenuItem(
                            child: Text('የጎደለ'),
                            value: 'የጎደለ',
                          ),
                          DropdownMenuItem(
                            child: Text('እርዳታ'),
                            value: 'እርዳታ',
                          ),
                        ],
                        value: initReason,
                        onChanged: (String value) {
                          setState(() {
                            initReason = value;
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
                      ),
                      Divider(),
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
                  // ),
                  ElevatedButton(
                      // style: StyleMedia.,

                      onPressed: () {
                        var today = EtDatetime.now().toString();
                        if (_forKey.currentState.validate()) {
                          var debt = Map<String, String>();
                          debt = {
                            'amount': amountController.text,
                            // 'startDate': workDateController.text,
                            'reason': initReason,
                            'date': today,
                            'empID': initEmpID == 'other' ? otherID : initEmpID,
                            'action': 'ADD_DEBT'
                          };
                          Utility.showAlertDialog(context, "Wait");
                          addDebt(debt).then((value) {
                            if (value == 'ok') {
                              Navigator.pop(context);
                              Utility.showSnakBar(
                                  "Done well", context, Colors.greenAccent);
                              setState(() {
                                initReason = 'ተበዳሪ';
                              });
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
                      child: Text('Save')),
                  Divider(
                    thickness: 2,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '''
List of Debt Record''',
                          style: Utility.textStyle,
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              initTable();
                            },
                            child: Text('Click')),
                      )
                    ],
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
                        DataColumn(label: Text('Total Debt')),
                        DataColumn(label: Text('Total Return')),
                        DataColumn(label: Text('Reminder')),
                        DataColumn(
                          label: Text('Action'),
                        ),
                        DataColumn(
                          label: Text('Detail'),
                        )
                      ],
                      rows: listRow,
                      // rows: getListOfCell()
                    ),
                  ),
                  listRow.length == 0 ? LinearProgressIndicator() : Divider()
                ],
              )),
        )
      ]),
    );
  }

  void initTable() {
    List<DataRow> _listRow = [];
// print("value= value");

    getDebt().then((value) {
// print("value= $value");
      var rows = jsonDecode(value) as List;

      for (var row in rows) {
        _listRow.add(DataRow(
            // selected: true,
            cells: [
              DataCell(Text(row['empID'])),
              DataCell(Text(row['totalDebt'])),
              DataCell(Text(row['totalreturn'])),
              DataCell(Text(
                  '${double.parse(row['totalDebt']) - double.parse(row['totalreturn'])}')),
              DataCell(TextButton(
                onPressed: () {
                  double totalDebt = double.parse(row['totalDebt']);
                  double totalReturn = double.parse(row['totalreturn']);
                  double total = totalDebt - totalReturn;
                  // var val = totalDebt == 0 || totalDebt > 1;
                  payDebt(row['empID'], '$total');
                  salaryController.text = total.toString();
                },
                child: Text('pay'),
              )),
              DataCell(TextButton(
                onPressed: () {
                  double totalReturn = double.parse(row['totalreturn']);
                  viewDetail(row['empID'], totalReturn);
                },
                child: Text('View Detail'),
              ))
            ]));
      }
      setState(() {
        listRow = _listRow;
      });
    });
  }

  void payDebt(String id, String left) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        // isScrollControlled: true,
        context: context,
        elevation: 10,
        // isScrollControlled: true,
        builder: (context) {
          return DraggableScrollableSheet(
              // expand: false,
              minChildSize: 0.5,
              initialChildSize: 0.9,
              maxChildSize: 0.9,
              builder: (_, controller) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: ListView(
                    // controller: controller,
                    // mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: salaryController,
                        // validator: (value) {
                        //   if (value.isEmpty)
                        //     return 'Please Enter Some value';
                        //   else if (double.tryParse(value) == null) {
                        //     return 'Please Enter number only';
                        //   }
                        //   return null;
                        // },
                        onChanged: (val) {},
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0.5)),
                            labelText: "Debt Amount",
                            // helperText: 'Paid Salary ',
                            prefixIcon: Icon(Icons.money)),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (salaryController.text == null) {
                              Utility.showSnakBar("Please Enter the amount",
                                  context, Colors.redAccent);
                            } else if (double.tryParse(salaryController.text) ==
                                null) {
                              Utility.showSnakBar("Please Enter number only",
                                  context, Colors.redAccent);
                            } else {
                              if (double.parse(left) <
                                  double.parse(salaryController.text)) {
                                Navigator.of(context).pop();
                                Utility.showSnakBar(
                                    "Your debt $left less than your input ${salaryController.text}",
                                    context,
                                    Colors.red);
                              } else if (salaryController.text == '0.0') {
                                Navigator.of(context).pop();
                                Utility.showSnakBar(
                                    "Already paid sir!", context, Colors.red);
                              } else {
                                var today = EtDatetime.now().toString();
                                addReturnDebt(today, id, salaryController.text,
                                        'open')
                                    .then((value) {
                                  if (value) {
                                    Navigator.of(context).pop();
                                    Utility.showSnakBar("Successfuly Done",
                                        context, Colors.greenAccent);
                                    setState(() {
                                      initTable();
                                    });
                                  }
                                });
                              }
                            }
                          },
                          child: Text('Pay')
                          // style: ButtonS,
                          )
                    ],
                  ),
                  // ),
                );
              });
        });
  }

  void viewDetail(String empID, double data) {
    showModalBottomSheet(
        // isScrollControlled: true,
        isScrollControlled: true,
        context: context,
        elevation: 10,
        builder: (context) {
          return DraggableScrollableSheet(
              expand: false,
              initialChildSize: 0.8,
              // maxChildSize: 0.7,
              builder: (_, controller) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    // color: Colors.red,
                    child: ListView(children: [
                      getDetilDebt(empID)

                      ///
                      ///
                      ///
                      ///
                      ///
                    ]),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20))),
                  ),
                );
              });
        });
  }

  Widget getDetilDebt(String empID) {
    for (int i = 0; i <= 5; i++) {
      return Container(child: Text('Data'));
    }
  }
}
