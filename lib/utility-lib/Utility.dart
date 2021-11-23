import 'package:abushakir/abushakir.dart';
import 'package:dabo/model-lib/DetailDabo.dart';
import 'package:dabo/model-lib/dabo.dart';
import 'package:dabo/model-lib/insert.dart';
import 'package:dabo/user-lib/detail.dart';
import 'package:flutter/material.dart';

import 'HttpRequest.dart';
import 'content_update.dart';
import 'detail_report.dart';

class Utility {
  static TextStyle get textStyle {
    return TextStyle(fontSize: 16.0, fontWeight: FontWeight.w800);
  }

  VoidCallback yesButton;
  VoidCallback noButton;
  static int geram = 70;
  static int geram75 = 1700;
  static int geram100 = 2300;
  static int geram120 = 2400;
  static int geram150 = 2600;
  static int geram200 = 2800;
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
    Utility.showAlertDialog(c, "እባክህ ትንሽ ጠብቅ");
    bool result = await Insert.insertDabo(dabo);
    Navigator.pop(c);
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
                          child: Icon(Icons.keyboard_arrow_right,
                              color: Colors.white),
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

  ///
  ///getDaboDetail method is used to display the detail
  ///dabo record by the given user
  ///

  static Widget getDaboDetail(
      BuildContext context, Future<List<DetailDabo>> detailDabo) {
    double value = 0.0;
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

                    return Container(
                      margin: EdgeInsets.all(5),
                      child: SelectableText(
                          '******************************************\n'
                          '*         በቀን ${dabo.date}  ለ${dabo.place} የወጣ      *\n'
                          '******************************************\n'
                          'ባለ 2.25 = ${dabo.bale_2_25} ዳቦ = ${double.parse(dabo.bale_2_25) * 2.25} ብር\n'
                          'ባለ 2.5 = ${dabo.bale_2_5} ዳቦ = ${double.parse(dabo.bale_2_5) * 2.5} ብር\n'
                          'ባለ 3= ${dabo.bale_3} ዳቦ = ${double.parse(dabo.bale_3) * 3} ብር\n'
                          'ባለ 5 = ${dabo.bale5} ዳቦ = ${double.parse(dabo.bale5) * 5} ብር\n'
                          'ባለ 10 = ${dabo.bale10} ዳቦ = ${double.parse(dabo.bale10) * 10} ብር\n'
                          'ባለ 75 = ${dabo.bale75} ዳቦ = ${double.parse(dabo.bale75) * 75} ብር\n'
                          'ባለ 100 = ${dabo.bale100} ዳቦ = ${double.parse(dabo.bale100) * 100} ብር\n'
                          'ባለ 120 = ${dabo.bale120} ዳቦ = ${double.parse(dabo.bale120) * 120} ብር\n'
                          'ባለ 150 = ${dabo.bale150} ዳቦ = ${double.parse(dabo.bale150) * 150} ብር\n'
                          'ባለ 200 = ${dabo.bale200} ዳቦ = ${double.parse(dabo.bale200) * 200} ብር\n'
                          '=====================================\n'
                          'የተከፈለ ብር = ${dabo.paidBirr} ብር\n'
                          'ያልተከፈለ ብር = ${dabo.unPaidBirr} ብር\n'
                          'የሒሳብ ሁኔታ = ${dabo.status}\n'
                          'Total paid ብር = $value ብር\n'
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
      contentPadding: EdgeInsets.all(20),
      title: Text(message),
      titlePadding: EdgeInsets.only(left: 10),
      elevation: 30,
      content: CircularProgressIndicator(
        backgroundColor: Colors.white,
      ),
    );
    showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  static getFrontListReport(BuildContext context, Future<List<Dabo>> daboList) {
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
                        'ኢንተርኔት የለም ወይም ሌላ ችግር ተፈጥሩል \n ለምሳሌ ${dabo.error.toString()} \n ***እባክህ ለ መሹ ደወል 0980631983*** ',
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
                        title:
                            Text('በቀን ${newDabo.date} የነበረውን የሽያጭ ሪፖርት ለማየት'),
                        subtitle: Text('የባለ ሞያው ስም: ${newDabo.userName}'),
                        leading: CircleAvatar(
                          backgroundColor: Colors.deepPurple[300],
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DetailReort(newDabo.date, newDabo.userName);
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
  }

  static double get75(String d75) {
    return (int.parse(d75) * geram75) / geram;
  }

  static double get100(String d100) {
    return (int.parse(d100) * geram100) / geram;
  }

  static double get120(String d120) {
    return (int.parse(d120) * geram120) / geram;
  }

  static double get150(String d150) {
    return (int.parse(d150) * geram150) / geram;
  }

  static double get200(String d200) {
    return (int.parse(d200) * geram200) / geram;
  }

  // static double get3(String d3) {
  //   return (int.parse(d3) * geram3) / geram;
  // }

  static Widget getDaboDetailReport(
      BuildContext context, Future<List<DetailDabo>> detailDabo, String date) {
    // Utility.showAlertDialog(context, 'Wait');
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
              var listOfReport = detialData.data;
              double totalUnPaidBirr = 0.0;
              double totalPaidBirr = 0.0;
              double totalDabo = 0.0;
              for (var eachReport in listOfReport) {
                totalPaidBirr =
                    totalPaidBirr + double.parse(eachReport.paidBirr);
                totalUnPaidBirr =
                    totalUnPaidBirr + double.parse(eachReport.unPaidBirr);
                totalDabo = (totalDabo +
                    (double.parse(eachReport.bale10) * 4) +
                    (double.parse(eachReport.bale5) * 2) +
                    double.parse(eachReport.bale_2_25) +
                    double.parse(eachReport.bale_2_5) +
                    get75(eachReport.bale75) +
                    double.parse(eachReport.bale_3) +
                    get100(eachReport.bale100) +
                    get120(eachReport.bale120) +
                    get150(eachReport.bale150) +
                    get200(eachReport.bale200));
              }
              return Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(5),
                width: double.infinity,
                child: Text('''
     በቀን $date የነበረው የሽያጭ ሪፖርት\n
አጠቃላይ የተጋገረው የዳቦ ብዛት = $totalDabo ዳቦ\n
አጠቃላይ ሽያጭ = ${totalPaidBirr + totalUnPaidBirr} ብር \n
ያልተከፈለ ሽያጭ =$totalUnPaidBirr ብር \n
የተከፈለ ሽያጭ =$totalPaidBirr ብር \n
      '''),
              );
            }
          }
          return Center(
              child: Container(
            child: CircularProgressIndicator(
              strokeWidth: 4,
              semanticsLabel: 'Wait',
              // backgroundColor: ,
              // value: 5.0,
            ),
          ));
        },
      ),
    );
  }

  ///
  ///get list of dabo for editting
  ///

  static Widget getFrontListForEditting(
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
                        title: Text('በቀን ${newDabo.date} የተሸጠውን ለማስተካከል',
                            style: TextStyle(fontSize: 14)),
                        subtitle: Text('የሥራ ቦታ: ${newDabo.place}'),
                        trailing: CircleAvatar(
                          backgroundColor: Colors.deepPurple[300],
                          child: Icon(Icons.delete_forever_sharp,
                              color: Colors.white),
                        ),
                        onTap: () {
                          var alertBoc = AlertDialog(
                            actions: [
                              TextButton(
                                  style: TextButton.styleFrom(
                                    animationDuration: Duration(seconds: 200),
                                    backgroundColor: Colors.blue[400],
                                  ),
                                  onPressed: () {
                                    showAlertDialog(context, "Wait");
                                    deleteDabo(newDabo.userName, newDabo.place,
                                            newDabo.date)
                                        .then((val) {
                                      if (val) {
                                        // UpdateHomeState.showResult();
                                        showSnakBar("Successfuly Delete",
                                            context, Colors.greenAccent);
                                        // UpdateHomeState. futureDabo =
                                        //     getListOfPlace(newDabo.userName,
                                        //         newDabo.date, context);
                                        Navigator.pop(context);
                                      } else {
                                        showSnakBar("Not Delete", context,
                                            Colors.redAccent);
                                      }
                                    });
                                  },
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              TextButton(
                                  style: TextButton.styleFrom(
                                    animationDuration: Duration(seconds: 200),
                                    backgroundColor: Colors.blue[400],
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "No",
                                    style: TextStyle(color: Colors.white),
                                  ))
                            ],
                            content: Text('ይህን መዝገብ ማጥፋት ትፈልጋለህ ?'),
                            title: Text('Deleting'),
                          );
                          showDialog(
                              context: context,
                              builder: (context) {
                                return alertBoc;
                              });
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
}
