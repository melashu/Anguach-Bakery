import 'package:dabo/model-lib/DetailDabo.dart';
import 'package:dabo/utility-lib/HttpRequest.dart';
import 'package:dabo/utility-lib/Utility.dart';
import 'package:dabo/utility-lib/content_update.dart';
import 'package:flutter/material.dart';

class Detail extends StatefulWidget {
  Detail(this.date, this.userName);
  String userName;
  String date;

  @override
  State<StatefulWidget> createState() {
    return DetailState(this.date, this.userName);
  }
}

class DetailState extends State<Detail> {
  DetailState(this.date, this.userName);
  // print
  Future<List<DetailDabo>> futureDetialDabo;

  String userName;
  String date;

  @override
  void initState() {
    super.initState();
    futureDetialDabo = getDetailDabo(userName, date);
    // print(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColorDark,

            appBar: AppBar(
        title: Text('በቀን ${this.date}  ${this.userName} የስራው፤ '),
      ),
      body: Utility.getDaboDetail(context, futureDetialDabo),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
            return UpdateHome(this.userName, date);
          }));
        },
        child: Icon(Icons.edit_outlined),
      ),
     

    );
  }
}
