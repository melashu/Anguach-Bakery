// import 'package:abushakir/abushakir.dart';
import 'package:dabo/utility-lib/HttpRequest.dart';
import 'package:dabo/utility-lib/Utility.dart';
import 'package:flutter/material.dart';

class ReturnDabo extends StatefulWidget {
  final String userName;
  ReturnDabo({this.userName});
  @override
  State<StatefulWidget> createState() {
    return ReturnDaboState(userName: this.userName);
  }
}

class ReturnDaboState extends State<ReturnDabo> {
  final String userName;
  var _formKey = GlobalKey<FormState>();
  var with_2_5 = TextEditingController()..text = '0';
  var with_5 = TextEditingController()..text = '0';
  var with_10 = TextEditingController()..text = '0';

  String initialPlace = 'መጋገሪያ';
  String initialDate;
  String newDate;
  var itemes = <DropdownMenuItem<String>>[];
  int bale2_5 = 0;
  int bale5 = 0;
  int bale10 = 0;

  @override
  void initState() {
    super.initState();
    getDateFromDatabase(userName);
  }

  ReturnDaboState({this.userName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(' $userName'),
        ),
        body: Container(
            child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Text(
                            "ቀን",
                            style: Utility.textStyle,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownButton<String>(
                            items: itemes,
                            value: initialDate,
                            onChanged: (String value) {
                              // late
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () {
                              setState(() {
                                initialDate = newDate;
                              });
                            },
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "የሥራ ቦታ",
                            style: Utility.textStyle,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownButton<String>(
                            items: [
                              DropdownMenuItem(
                                child: Text('መጋገሪያ'),
                                value: 'መጋገሪያ',
                              ),

                              DropdownMenuItem(
                                child: Text('ጎማጣ'),
                                value: 'ጎማጣ',
                              ),
                              // Divider(),
                              DropdownMenuItem(
                                child: Text('መድሃኒዓለም'),
                                value: 'መድሃኒዓለም',
                              ),
                              DropdownMenuItem(
                                child: Text('ሲቭ'),
                                value: 'ሲቭ',
                              )
                            ],
                            value: initialPlace,
                            onChanged: (String value) {
                              setState(() {
                                initialPlace = value;
                              });
                            },
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            // padding: const EdgeInsets.all(8.0),
                            // flex: 2,
                            child: Container(
                              // width: 200,
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              child: TextFormField(
                                autocorrect: true,
                                validator: (val) {
                                  var isNum = num.tryParse(val);
                                  if (val.isEmpty) {
                                    return "እባክህ ብዛቱን  አስገባ";
                                  } else if (isNum == null) {
                                    return "እባክህ ቁጥር ብቻ አስገባ";
                                  } else
                                    return null;
                                },
                                onChanged: (String val) {
                                  if (_formKey.currentState.validate()) {}
                                },
                                textInputAction: TextInputAction.next,
                                keyboardAppearance: Brightness.light,
                                keyboardType: TextInputType.number,
                                controller: with_2_5,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'ባለ 2.5 ብር ዳቦ',
                                    hintText: 'ለምሳሌ 200',
                                    errorStyle: TextStyle(
                                      color: Colors.redAccent,
                                      fontStyle: FontStyle.italic,
                                    )),
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(""))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            // margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 10, right: 10),
                              child: TextFormField(
                                autocorrect: true,
                                validator: (val) {
                                  var isNum = num.tryParse(val);
                                  if (val.isEmpty) {
                                    return "እባክህ ብዛቱን  አስገባ";
                                  } else if (isNum == null) {
                                    return "እባክህ ቁጥር ብቻ አስገባ";
                                  } else
                                    return null;
                                },
                                onChanged: (String val) {
                                  if (_formKey.currentState.validate()) {}
                                },
                                textInputAction: TextInputAction.next,
                                keyboardAppearance: Brightness.light,
                                keyboardType: TextInputType.number,
                                controller: with_5,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'ባለ 5 ብር ዳቦ',
                                    hintText: 'ለምሳሌ 20',
                                    errorStyle: TextStyle(
                                      color: Colors.redAccent,
                                      fontStyle: FontStyle.italic,
                                    )),
                              ),
                            ),
                          ),
                          Container(child: Text( ''))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            // margin: EdgeInsets.only(top: 10, bottom: 10),
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: TextFormField(
                                autocorrect: true,
                                validator: (val) {
                                  var isNum = num.tryParse(val);
                                  if (val.isEmpty) {
                                    return "እባክህ ብዛቱን  አስገባ";
                                  } else if (isNum == null) {
                                    return "እባክህ ቁጥር ብቻ አስገባ";
                                  } else
                                    return null;
                                },
                                onChanged: (String val) {
                                  if (_formKey.currentState.validate()) {}
                                },
                                textInputAction: TextInputAction.next,
                                keyboardAppearance: Brightness.light,
                                keyboardType: TextInputType.number,
                                controller: with_10,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'ባለ 10 ብር ዳቦ',
                                    hintText: 'ለምሳሌ 20',
                                    errorStyle: TextStyle(
                                      color: Colors.redAccent,
                                      fontStyle: FontStyle.italic,
                                    )),
                              ),
                            ),
                          ),
                          Container(child: Text(""))
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10, bottom: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              var dabo = Map<String, dynamic>();

                              dabo['userName'] = this.userName;
                              dabo['date'] = this.initialDate;
                              dabo['place'] = this.initialPlace;
                              dabo['bale_2_5'] = with_2_5.text;
                              dabo['bale_5'] = with_5.text;
                              dabo['bale_10'] = with_10.text;
                              dabo['action'] = 'RETURN_DABO';
                              Utility.insertDabo(dabo, context);
                            },
                            child: Text('Save'),
                            style: ButtonStyle(
                                animationDuration: Duration(seconds: 6)),
                          )),
                          Divider(thickness: 6),
                          Center(
                            child: Text('የተመላሽ ዳቦ ዝርዝር',style: Utility.textStyle),

                          ),
                          Divider(thickness: 6),

                    ],
                  ),
                ))));
  }

  void getDateFromDatabase(String userName) {
    futureDateModel(userName).then((value) {
      this.newDate = value[0].date;
      //
      // print('date of=${PayementState.newDate}');
      for (var date in value) {
        itemes.add(DropdownMenuItem<String>(
          child: Text(date.date),
          value: date.date,
        ));
      }
    });
  }
}
