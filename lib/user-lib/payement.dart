// import 'package:dabo/model-lib/date_model.dart';
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
  String newDate;
  String initialDate;
  String date11;

  // Utility.initDate;
  // =PayementState.initDate;
  var paidBirrController = TextEditingController()..text = '0';
  // var unPaidBirrController = TextEditingController()..text = '0';
  double unPaidBirr = 0;
  double paidBirr = 0;
  var items = <DropdownMenuItem<String>>[];
// int 1a;
  var formKey = GlobalKey<FormState>();
  int itemCount = 0;

  @override
  void initState() {
    super.initState();
    getDateFromDatabase(userName);
    getNewPayement();
  }

  PayementState(this.userName, this.initialDate);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        persistentFooterButtons: [
          CircleAvatar(
            backgroundColor: itemCount > 0 ? Colors.red : Colors.blueAccent,
            child: Text("$itemCount",
                style: TextStyle(
                    color: itemCount > 0 ? Colors.white : Colors.white)),
          ),
          Text("New Payement",
              style: TextStyle(
                color: itemCount > 0 ? Colors.red : Colors.white,
              )),
        ],
        appBar: AppBar(
            title: Text(
                '*${this.userName.toLowerCase() == 'all' ? 'Meshu' : this.userName}* እንኮን ደህና መጣህ')),
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
                  child: Text(
                      'Dear ${this.userName.toLowerCase() == 'all' ? 'Meshu' : this.userName}'),
                ),
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          "ቀን",
                          style: Utility.textStyle,
                        ),
                        IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () {
                              setState(() {
                                newDate = this.date11;
                              });
                            })
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    DropdownButton<String>(
                      items: items,
                      value: newDate,
                      onChanged: (String value) {
                        setState(() {
                          newDate = value;
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
                        });
                        getBirr(newDate, initialPlace);
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
                        filled: true,
                        // hasFloatingPlaceholder: true,
                        // floatingLabelBehavior: FloatingLabelBehavior.,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.orangeAccent, width: 2)),
                        labelText: 'የብሩ መጠን',
                        hintText: 'ለምሳሌ 200 ብር',
                        errorStyle: TextStyle(
                          color: Colors.red,
                          fontStyle: FontStyle.italic,
                        )),
                  ),
                ),
                Divider(
                  thickness: 3.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$initialPlace ላይ ያልተከፈለ ብር $unPaidBirr ብር',
                    style: Utility.textStyle,
                  ),
                ),
                Divider(
                  thickness: 3.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$initialPlace ላይ የተከፈለ ብር $paidBirr ብር',
                    style: Utility.textStyle,
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    if (paidBirrController.text == '0' ||
                        paidBirrController.text.isEmpty) {
                      Utility.showSnakBar(
                          "እባክህ የምትከፍለውን ብር አስገባ", context, Colors.red[400]);
                    } else if (newDate.isEmpty) {
                      Utility.showSnakBar(
                          "እባክህ ቀኑን ምርት", context, Colors.red[400]);
                    } else if (this.unPaidBirr == 0) {
                      Utility.showSnakBar(
                          "${this.initialPlace} ላይ ሁሉም ሒሳብ ከዚህ በፊት ተከፍሎል ፡፡",
                          context,
                          Colors.red[400]);
                    } else {
                      Utility.showAlertDialog(context, "እባክህ ትንሽ ጠብቅ");
/**
 *  double oldPaiedBirr,
      double oldUnPaidBirr,
      double newPaidBirr,
      String date,
      String place,
      String userName,
      BuildContext context
 */

                      // print(paidBirrController.text is String);
                      PayementUpdate.updatePayement(
                              this.paidBirr,
                              this.unPaidBirr,
                              paidBirrController.text,
                              this.newDate,
                              this.initialPlace,
                              userName,
                              context)
                          .then((value) {
                        Navigator.pop(context);
                        if (value) {
                          Utility.showSnakBar(
                              "ሒሳቦ በትክክል ተከፍሎል ", context, Colors.green[400]);
                          setState(() {
                            this.unPaidBirr = this.unPaidBirr -
                                double.parse(paidBirrController.text);
                            this.paidBirr = this.paidBirr +
                                double.parse(paidBirrController.text);
                          });
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
    // return PayementState.newDate;
  }

  void getDateFromDatabase(String userName) {
    futureDateModel('all').then((value) {
      this.date11 = value[0].date;
      //
      // print('date of=${PayementState.newDate}');
      for (var date in value) {
        items.add(DropdownMenuItem<String>(
          child: Text(date.date),
          value: date.date,
        ));
      }
    });
  }

  void getBirr(String date, String place) async {
    Utility.showAlertDialog(context, "እባክህ ትንሽ ጠብቅ");
    var payementModel = await futurePayementModel('all', date, place);
    Navigator.pop(context, true);
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

  void getNewPayement() {
    getNewPayementNotification().then((value) {
      setState(() {
        itemCount = value;
      });
    });
  }
}
