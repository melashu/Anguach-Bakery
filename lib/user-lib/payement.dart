import 'package:dabo/model-lib/date_model.dart';
import 'package:dabo/model-lib/payement_update.dart';
import 'package:dabo/utility-lib/HttpRequest.dart';
import 'package:dabo/utility-lib/Utility.dart';
import 'package:flutter/material.dart';

class Payement extends StatefulWidget {
  Payement(this.userName, this.initDate);
  String userName;
  String initDate;
  @override
  State<StatefulWidget> createState() {
    return PayementState(this.userName, this.initDate);
  }
}

class PayementState extends State<Payement> {
  String userName;
  String initialPlace = 'መጋገሪያ';
  static String newDate;
  String initialDate;

  // Utility.initDate;
  // =PayementState.initDate;
  var paidBirrController = TextEditingController()..text = '0';
  // var unPaidBirrController = TextEditingController()..text = '0';
  double unPaidBirr = 0;
  double paidBirr = 0;
  var items = <DropdownMenuItem<String>>[];
// int 1a;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getDateFromDatabase(userName);
    // initDate;
  }

  // var onPressed;
  PayementState(this.userName, this.initialDate);
  @override
  Widget build(BuildContext context) {
    print("Today=$initialDate");
    return Scaffold(
        appBar: AppBar(
            title: Text('*${this.userName.toUpperCase()}* እንኮን ደህና መጣህ')),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                AnimatedContainer(
                  margin: EdgeInsets.all(5),
                  alignment: Alignment.center,
                  duration: Duration(seconds: 5),
                  child: Text('Dear $userName '),
                ),
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
                      items: items,
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
                        getBirr(initialDate, initialPlace);
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
                        return "የብሩ መጠን አስገባ";
                      } else if (isNum == null) {
                        return "እባክህ ቁጥር ብቻ አስገባ";
                      } else
                        return null;
                    },
                    onChanged: (String val) {
                      if (formKey.currentState.validate()) {}
                    },
                    textInputAction: TextInputAction.next,
                    keyboardAppearance: Brightness.light,
                    keyboardType: TextInputType.number,
                    controller: paidBirrController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'የብሩ መጠን',
                        hintText: 'ለምሳሌ 200 ብር',
                        errorStyle: TextStyle(
                          color: Colors.yellowAccent,
                          fontStyle: FontStyle.italic,
                        )),
                  ),
                ),
                Divider(
                  thickness: 3.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('$initialPlace ላይ ያልተከፈለ ብር $unPaidBirr ብር'),
                ),
                Divider(
                  thickness: 3.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('$initialPlace ላይ የተከፈለ ብር $paidBirr ብር'),
                ),
                OutlinedButton(
                  onPressed: () {
                    if (paidBirrController.text == '0') {
                      Utility.showSnakBar(
                          "እባክህ የምትከፍለውን ብር አስገባ", context, Colors.yellow[400]);
                    } else {
                      PayementUpdate.updatePayement(
                              this.paidBirr,
                              this.unPaidBirr,
                              double.parse(paidBirrController.text),
                              this.initialDate,
                              this.initialPlace,
                              userName)
                          .then((value) {
                        if (value) {
                          Utility.showSnakBar(
                              "ሒሳቦ በትክክል ተከፍሎል ", context, Colors.green[400]);
                        } else {
                          Utility.showSnakBar(
                              "ይቅርታ ሒሳቦን መክፈል አልተቻለም፡፡ ለመሹ 0980631983 ",
                              context,
                              Colors.red[400]);
                        }
                      });
                    }
                  },
                  child: Text('ክፈል'),
                  autofocus: true,
                )
              ],
            ),
          ),
        ));
  }

  static String get getDate {
    // setStat
    return PayementState.newDate;
  }

  void getDateFromDatabase(String userName) {
    futureDateModel(userName).then((value) {
      // PayementState.newDate = value[0].date;
      print('date of=${PayementState.newDate}');
      for (var date in value) {
        items.add(DropdownMenuItem<String>(
          child: Text(date.date),
          value: date.date,
        ));
      }
    });
  }

  void getBirr(String date, String place) async {
    var payementModel = await futurePayementModel(userName, date, place);
    double val1 = 0;
    double val2 = 0;
    for (var pay in payementModel) {
      val1 = val1 + double.parse(pay.unPaidBirr);
      val2 = val2 + double.parse(pay.paidBirr);
    }
    setState(() {
      unPaidBirr = val1;
      paidBirr = val2;
    });
  }
}
