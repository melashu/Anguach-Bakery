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
  final geram = 75;
  var _formKey = GlobalKey<FormState>();
  /***
   * with varibale used for accesing textfield value 
   */
  var with_2_25 = TextEditingController()..text = '0';
  var with_2_5 = TextEditingController()..text = '0';
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
                        child: Text('ትዕዛዝ'),
                        value: 'ትዕዛዝ',
                      ),
                      DropdownMenuItem(
                        child: Text('ጎማጣ'),
                        value: 'ጎማጣ',
                      ),
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
                      border: OutlineInputBorder(),
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
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            var dabo = Map<String, String>();
                            dabo = {
                              'userName': this.userName,
                              'date': this.initialDate,
                              'place': this.initialPlace,
                              'bale_2_25': with_2_25.text,
                              'bale_2_5': with_2_5.text,
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
                          }
                        });
                      },
                      child: Text('Save'),
                    ),
                  ),
                  Container(margin: EdgeInsets.only(left: 5, right: 5)),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('ዝርዝሩን ለማየት'),
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
    var bale5 = int.parse(with_5.text) * cost5;
    var bale10 = int.parse(with_10.text) * cost10;
    var bale75 = int.parse(with_75_d.text) * cost75;
    var bale100 = int.parse(with_100_d.text) * cost100;
    var bale120 = int.parse(with_120_d.text) * cost120;
    var bale150 = int.parse(with_150_d.text) * cost150;
    var bale200 = int.parse(with_200_d.text) * cost200;
    /***
     * amont variable stores the total bread made today  
     */
    // totalItem=${};
    // var amont2_5 = int.parse(with_2_5.text);
    // var amont5 = (int.parse(with_5.text) * 2);
    // var amont10 = (int.parse(with_10.text) * 4);
    // var amont75 = ((int.parse(with_75_d.text) * 2000) / geram);
    // var amont100 = ((int.parse(with_100_d.text) * 2500) / geram);
    // var amont120 = ((int.parse(with_120_d.text) * 2700) / geram);
    // var amont150 = ((int.parse(with_150_d.text) * 2900) / geram);
    // var amont200 = ((int.parse(with_200_d.text) * 3000) / geram);
    // totalItem =
    //     'አጠቃላይ ዳቦ = ${amont2_5 + amont5 + amont10 + amont75 + amont100 + amont120 + amont150 + amont200}';
    /***
     * total stores the total sales held on today 
     */
    var total = bale_2_25 +
        bale_2_5 +
        bale5 +
        bale10 +
        bale75 +
        bale120 +
        bale100 +
        bale150 +
        bale200;

    return total.toString();
  }

  // void insertDabo(Map<String, dynamic> dabo, BuildContext c) async {
  //   bool result = await Insert.insertDabo(dabo);
  //   if (result) {
  //     showSnakBar("በትክክል ተመዝግቦል", c, Colors.greenAccent);
  //   } else {
  //     showSnakBar("ይቅርታ ዳቦው አልተመዘገበም", c, Colors.white30);
  //   }
  // }

  // void showSnakBar(String s, BuildContext c, Color color) {
  //   var snackbar = SnackBar(
  //       content: Text(
  //         s,
  //         style: Utility.textStyle,
  //       ),
  //       elevation: 10,
  //       backgroundColor: color,
  //       action: SnackBarAction(
  //         label: 'Close',
  //         textColor: color,
  //         onPressed: () {
  //           // ScaffoldFeatureController.
  //           ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //         },
  //       ));
  //   ScaffoldMessenger.of(context).showSnackBar(snackbar);
  // }
}
