import 'package:abushakir/abushakir.dart';
import 'package:dabo/model-lib/DetailDabo.dart';
import 'package:dabo/model-lib/dabo.dart';
import 'package:dabo/model-lib/insert.dart';
import 'package:dabo/user-lib/detail.dart';
import 'package:flutter/material.dart';

import 'HttpRequest.dart';

class Utility {
  static TextStyle get textStyle {
    return TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800);
  }

  double _totalPaidBirr = 0;
  double _totalUnPaidBirr = 0;
  int _totalDabo = 0;

  static List<DropdownMenuItem<String>> get getDate {
    var items = <DropdownMenuItem<String>>[];
    var ethDate =
        '${EtDatetime.now().day}/${EtDatetime.now().month}/${EtDatetime.now().year}';
    // ethDate.year;
    items.add(DropdownMenuItem<String>(
      child: Text("$ethDate"),
      value: "$ethDate",
    ));
    return items;
  }

  static Future<List<DropdownMenuItem<String>>> getDateFromDatabase(
      String userName) async {
    var items = <DropdownMenuItem<String>>[];
    var listDate = await futureDateModel(userName);
    for (var date in listDate) {
      items.add(DropdownMenuItem<String>(
        child: Text(date.date),
        value: date.date,
      ));
    }

    return items;
  }

  static String get initDate {
    var ethDate =
        '${EtDatetime.now().day}/${EtDatetime.now().month}/${EtDatetime.now().year}';
    return ethDate;
  }

  static void insertDabo(Map<String, dynamic> dabo, BuildContext c) async {
    showAlertDialog(c, "Wait");
    bool result = await Insert.insertDabo(dabo);
    if (result) {
      showSnakBar("በትክክል ተመዝግቦል", c, Colors.greenAccent);
    } else {
      showSnakBar("ይቅርታ ዳቦው  አልተመዘገበም", c, Colors.red[400]);
    }
  }

  static void showSnakBar(String message, BuildContext c, Color color) {
    var snackbar = SnackBar(
        content: Text(
          message,
          style: Utility.textStyle,
        ),
        elevation: 10,
        backgroundColor: color,
        action: SnackBarAction(
          label: 'Close',
          textColor: color,
          onPressed: () {
            ScaffoldMessenger.of(c).hideCurrentSnackBar();
          },
        ));
    ScaffoldMessenger.of(c).showSnackBar(snackbar);
  }

  static Widget getFrontList(
      BuildContext context, Future<List<Dabo>> daboList) {
    return Container(
      child: FutureBuilder<List<Dabo>>(
          future: daboList,
          builder: (context, dabo) {
            if (dabo.connectionState == ConnectionState.done) {
              if (dabo.hasError) {
                print(dabo.error.toString());
                return Center(
                  child: Container(
                      padding: EdgeInsets.all(15),
                      color: Colors.redAccent,
                      child: Text(
                        'ችግር ተፈጥሩል \n ለምሳሌ ${dabo.error.toString()} \n ***እባክህ ለ መሹ ደወል 0980631983*** ',
                        style: Utility.textStyle,
                      )),
                );
              } else if (dabo.hasData) {
                return ListView.builder(
                  itemCount: dabo.data.length,
                  padding: EdgeInsets.all(15),
                  itemBuilder: (BuildContext context, int index) {
                    Dabo newDabo = dabo.data[index];
                    return Card(
                      child: ListTile(
                        title: Text('በቀን ${newDabo.date} የተሸጠውን ለማየት'),
                        subtitle: Text('የባለ ሞያው ስም: ${newDabo.userName}'),
                        leading: CircleAvatar(
                          backgroundColor: Colors.deepPurple[300],
                          child: Icon(Icons.keyboard_arrow_right),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Detail(newDabo.date, newDabo.userName);
                          }));
                        },
                      ),
                    );
                  },
                );
              }
            }
            return Center(
                child: Container(
              child: CircularProgressIndicator(
                strokeWidth: 8,
                semanticsLabel: 'Wait',
              ),
            ));
          }),
    );
    // return null;
  }

  double get totalPaidBirr {
    return _totalPaidBirr;
  }

  double get totalUnPaidBirr {
    return _totalUnPaidBirr;
  }

  int get totalDabo {
    return _totalDabo;
  }

  ///
  ///getDaboDetail method is used to display the detail
  ///dabo record by the given user
  ///

  static Widget getDaboDetail(
      BuildContext context, Future<List<DetailDabo>> detailDabo) {
    return Container(
      child: FutureBuilder<List<DetailDabo>>(
        future: detailDabo,
        builder: (context, detialData) {
          if (detialData.connectionState == ConnectionState.done) {
            if (detialData.hasError) {
              return Center(
                child: Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.all(5),
                    color: Colors.redAccent,
                    child: Text(
                      'ችግር ተፈጥሩል \n ለምሳሌ ${detialData.error.toString()} \n ***እባክህ ለ መሹ ደወል 0980631983*** ',
                      style: Utility.textStyle,
                      textAlign: TextAlign.justify,
                    )),
              );
            } else {
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: detialData.data.length,
                  itemBuilder: (context, index) {
                    DetailDabo dabo = detialData.data[index];
                    // print(dabo.unPaidBirr);
                    Utility()._totalPaidBirr =
                        Utility()._totalPaidBirr + double.parse(dabo.paidBirr);
                    Utility()._totalUnPaidBirr = Utility()._totalUnPaidBirr +
                        double.parse(dabo.unPaidBirr);

                    return Container(
                      margin: EdgeInsets.all(5),
                      child: SelectableText(
                          '******************************************\n'
                          '*         በቀን ${dabo.date}  ለ${dabo.place} የወጣ      *\n'
                          '******************************************\n'
                          'ባለ 2.25 = ${dabo.bale_2_25} = ${double.parse(dabo.bale_2_25) * 2.25} ብር\n'
                          'ባለ 2.5 = ${dabo.bale_2_5} = ${double.parse(dabo.bale_2_5) * 2.5} ብር\n'
                          'ባለ 5 = ${dabo.bale5} = ${double.parse(dabo.bale5) * 5} ብር\n'
                          'ባለ 10 = ${dabo.bale10} = ${double.parse(dabo.bale10) * 10} ብር\n'
                          'ባለ 75 = ${dabo.bale75} = ${double.parse(dabo.bale75) * 75} ብር\n'
                          'ባለ 100 = ${dabo.bale100} = ${double.parse(dabo.bale100) * 100} ብር\n'
                          'ባለ 120 = ${dabo.bale120} = ${double.parse(dabo.bale120) * 120} ብር\n'
                          'ባለ 150 = ${dabo.bale150} = ${double.parse(dabo.bale150) * 150} ብር\n'
                          'ባለ 200 = ${dabo.bale200} = ${double.parse(dabo.bale200) * 200} ብር\n'
                          '=====================================\n'
                          'የተከፈለ ብር = ${dabo.paidBirr} ብር\n'
                          'ያልተከፈለ ብር = ${dabo.unPaidBirr} ብር\n'
                          'የሒሳብ ሁኔታ = ${dabo.status}\n'
                          '=====================================\n'),
                    );
                  });
            }
          }
          return Center(
              child: Container(
            child: CircularProgressIndicator(
              strokeWidth: 8,
              semanticsLabel: 'Wait',
              // backgroundColor: ,
              // value: 5.0,
            ),
          ));
        },
      ),
    );
  }

  static void showAlertDialog(BuildContext context, String message) {
    var alertDialog = AlertDialog(
      title: Text(message),
      elevation: 30,
      content: CircularProgressIndicator(
        strokeWidth: 10,
        backgroundColor: Colors.blueAccent,
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }
}
