// import 'package:dabo/model-lib/insert.dart';
import 'package:dabo/utility-lib/Utility.dart';
import 'package:flutter/material.dart';

// import 'Utility.dart';

class Body extends StatefulWidget {
  String userName;

  Body({this.userName});
  @override
  State<StatefulWidget> createState() {
    return _BodyState(userName: this.userName);
  }
}

class _BodyState extends State<Body> {
  String userName;
  _BodyState({this.userName});

  _BodyState.forEditing(Map fromDb, String userName) {
    this.with_2_25.text = fromDb['bale_2_25'];
    this.with_2_5.text = fromDb['bale_2_5'];
    this.with_3.text = fromDb['bale_3'];

    this.with_5.text = fromDb['bale_5'];

    this.with_10.text = fromDb['bale_10'];
    this.with_75_d.text = fromDb['bale_75'];
    this.with_100_d.text = fromDb['bale_100'];
    this.with_120_d.text = fromDb['bale_120'];
    this.with_150_d.text = fromDb['bale_150'];
    this.with_200_d.text = fromDb['bale_200'];
    this.initialDate = fromDb['date'];
    this.initialPlace = fromDb['place'];
    this.isForEditing = true;
  }
  final geram = 75;
  var _formKey = GlobalKey<FormState>();

  /// isForEditing is to check wether the button is ready for editting or not
  bool isForEditing = false;

  /// with varibale used for accesing textfield value

  var with_2_25 = TextEditingController()..text = '0';
  var with_2_5 = TextEditingController()..text = '0';
  var with_3 = TextEditingController()..text = '0';


  var with_5 = TextEditingController()..text = '0';
  var with_10 = TextEditingController()..text = '0';
  var with_75_d = TextEditingController()..text = '0';
  var with_100_d = TextEditingController()..text = '0';
  var with_120_d = TextEditingController()..text = '0';
  var with_150_d = TextEditingController()..text = '0';
  var with_200_d = TextEditingController()..text = '0';
  var initialPlace = 'መጋገሪያ';
  var initialDate = Utility.initDate;
  var totalPrices = '';
  var totalItem = '';
  var totalSale = '';

  // ignore: slash_for_doc_comments
  /**
   * cost variable store indvidual cost value 
   */
  var cost2_25 = 2.25;
  var cost2_5 = 2.5;
  var cost_3 = 3;

  var cost5 = 5;
  var cost10 = 10;
  var cost75 = 75;
  var cost100 = 100;
  var cost120 = 120;
  var cost150 = 150;
  var cost200 = 200;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('የዳቦ መመዝገቢያ በ $userName'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, true);
            }),
      ),
      body: Form(
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
                    items: Utility.getDate,
                    value: initialDate,
                    onChanged: (String value) {
                      setState(() {
                        initialDate = value;
                      });
                    },
                  ),
                  Spacer(),
                  OutlinedButton(onPressed: () {
                     setState(() {
                          if (_formKey.currentState.validate()) {
                            var dabo = Map<String, String>();
                            dabo = {
                              'userName': this.userName,
                              'date': this.initialDate,
                              'place': this.initialPlace,
                              'bale_2_25': with_2_25.text,
                              'bale_2_5': with_2_5.text,
                              'bale_3': with_3.text,
                              'bale_5': with_5.text,
                              'bale_10': with_10.text,
                              'bale_75': with_75_d.text,
                              'bale_100': with_100_d.text,
                              'bale_120': with_120_d.text,
                              'bale_150': with_150_d.text,
                              'bale_200': with_200_d.text,
                              'unPaidBirr': calculatPrices(),
                              'action': 'ADD_DABO'
                            };

                            Utility.insertDabo(dabo, context);
                            // Navigator.pop(context,true);
                          }
                        });
                  }, child: Text('Save'))
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
                        child: Text('ትዕዛዝ'),
                        value: 'ትዕዛዝ',
                      ),
                      DropdownMenuItem(
                        child: Text('ጎማጣ'),
                        value: 'ጎማጣ',
                      ),
                      DropdownMenuItem(
                        child: Text('ሜድሮክ'),
                        value: 'ሜድሮክ',
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
                        // print('Date =$initialPlace');
                      });
                    },
                  )
                ],
              ),
              Container(
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
                  controller: with_2_25,
                  // initialValue: '0',
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ባለ 2.25 ብር ዳቦ',
                      hintText: 'ለምሳሌ 200',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontStyle: FontStyle.italic,
                      )),
                ),
              ),
              Container(
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
                  // initialValue: '0',
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ባለ 2.50 ብር ዳቦ',
                      hintText: 'ለምሳሌ 200',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontStyle: FontStyle.italic,
                      )),
                ),
              ),
               Container(
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
                  controller: with_3,
                  // initialValue: '0',
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ባለ 3 ብር ዳቦ',
                      hintText: 'ለምሳሌ 200',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontStyle: FontStyle.italic,
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
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
                      hintText: 'ለምሳሌ 100',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontStyle: FontStyle.italic,
                      )),

                      /***
                       * 
                       */
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
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
                      hintText: 'ለምሳሌ 30',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontStyle: FontStyle.italic,
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
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
                  controller: with_75_d,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ባለ 75 ብር ድፎ',
                      hintText: 'ለምሳሌ 2',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontStyle: FontStyle.italic,
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  autocorrect: true,
                  validator: (val) {
                    var isNum = num.tryParse(val);
                    if (val.isEmpty) {
                      return "እባክህ ብዛቱን አስገባ or 0";
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
                  controller: with_100_d,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ባለ 100 ብር ድፎ',
                      hintText: 'ለምሳሌ 2',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontStyle: FontStyle.italic,
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
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
                  controller: with_120_d,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ባለ 120 ብር ድፎ',
                      hintText: 'ለምሳሌ 2',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontStyle: FontStyle.italic,
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
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
                  controller: with_150_d,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        
                      ),
                      labelText: 'ባለ 150 ብር ድፎ',
                      hintText: 'ለምሳሌ 2',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontStyle: FontStyle.italic,
                      )),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
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
                  controller: with_200_d,
                  decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2)),
                      border: OutlineInputBorder(),
                      labelText: 'ባለ 200 ብር ድፎ',
                      hintText: 'ለምሳሌ 2',
                      errorStyle: TextStyle(
                        color: Colors.yellowAccent,
                        fontStyle: FontStyle.italic,
                      )),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        if (!isForEditing) {
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              var dabo = Map<String, String>();
                              dabo = {
                                'userName': this.userName,
                                'date': this.initialDate,
                                'place': this.initialPlace,
                                'bale_2_25': with_2_25.text,
                                'bale_2_5': with_2_5.text,
                                'bale_3': with_3.text,
                                'bale_5': with_5.text,
                                'bale_10': with_10.text,
                                'bale_75': with_75_d.text,
                                'bale_100': with_100_d.text,
                                'bale_120': with_120_d.text,
                                'bale_150': with_150_d.text,
                                'bale_200': with_200_d.text,
                                'unPaidBirr': calculatPrices(),
                                'action': 'ADD_DABO'
                              };

                              Utility.insertDabo(dabo, context);
                              // Navigator.pop(context,true);
                            }
                          });
                        } else {
                          Utility.showSnakBar(
                              "Please click the edit button than save button",
                              context,
                              Colors.redAccent);
                        }
                      },
                      child: Text('Save'),
                    ),
                  ),
                  Container(margin: EdgeInsets.only(left: 5, right: 5)),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        if (!isForEditing) {
                          Utility.showSnakBar(
                              "Please click the edit button than save button",
                              context,
                              Colors.redAccent);
                        } else {
                          /// do update call
                        }
                      },
                      child: Text('Update'),
                    ),
                  )
                ],
              ),
              Divider(
                color: Colors.white30,
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String calculatPrices() {
    var bale_2_25 = int.parse(with_2_25.text) * cost2_25;
    var bale_2_5 = int.parse(with_2_5.text) * cost2_5;
    var bale_3 = int.parse(with_3.text) * cost_3;

    var bale5 = int.parse(with_5.text) * cost5;
    var bale10 = int.parse(with_10.text) * cost10;
    var bale75 = int.parse(with_75_d.text) * cost75;
    var bale100 = int.parse(with_100_d.text) * cost100;
    var bale120 = int.parse(with_120_d.text) * cost120;
    var bale150 = int.parse(with_150_d.text) * cost150;
    var bale200 = int.parse(with_200_d.text) * cost200;

    var total = bale_2_25 +
        bale_2_5 +
        bale_3 +
        bale5 +
        bale10 +
        bale75 +
        bale120 +
        bale100 +
        bale150 +
        bale200;

    return total.toString();
  }
}
