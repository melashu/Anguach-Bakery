import 'package:dabo/model-lib/dabo.dart';
import 'package:dabo/user-lib/AddDabo.dart';
import 'package:dabo/utility-lib/HttpRequest.dart';
import 'package:dabo/utility-lib/Utility.dart';
import 'package:flutter/material.dart';

class UpdateHome extends StatefulWidget {
  String userName;
  String date;

  UpdateHome(this.userName, this.date);
  @override
  State<StatefulWidget> createState() {
    return UpdateHomeState(this.userName, this.date);
  }
}

class UpdateHomeState extends State<UpdateHome> {
  String userName;
  String date;

  static Future<List<Dabo>> futureDabo;

  static Future<List<Dabo>> get getFuture {
    return futureDabo;
  }

  @override
  void initState() {
    super.initState();
    futureDabo = getListOfPlace(userName, date, context);
  }

  UpdateHomeState(this.userName, this.date);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$userName የማሻሻያ ገጽ ላይ ነህ',style: TextStyle(fontSize: 17),), 
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(Icons.replay_rounded),
            onPressed: () {
              setState(() {
                futureDabo = getListOfPlace(userName, date, context);
              });
            },
          ),
        )
      ]
      ),
      body: Utility.getFrontListForEditting(context, futureDabo),
  floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Body(
                userName: this.userName,
              );
            })).then((value) {
              setState(() {
                futureDabo = getListOfDabo(userName);
              });
            });
          },
          tooltip: 'ዳቦ መዝግብ',
          child: Icon(Icons.add),
        )
    );
  }

  // static void showResult() {
  //  Utility.showSnakBar("Successfuly Delete", context, Colors.greenAccent);
  //   UpdateHomeState.futureDabo =
  //       getListOfPlace(this.userName, this.date, context);
  //   Navigator.pop(context);
  // }
}
