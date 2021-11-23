import 'package:dabo/model-lib/DetailDabo.dart';
import 'package:flutter/material.dart';

import 'HttpRequest.dart';
import 'Utility.dart';

class DetailReort extends StatefulWidget {
  DetailReort(this.date, this.userName);
  String userName;
  String date;
  @override
  State<StatefulWidget> createState() {
    return DetailReportState(this.date, this.userName);
  }
}

class DetailReportState extends State<DetailReort> {
  DetailReportState(this.date, this.userName);
  // print
  Future<List<DetailDabo>> futureDetialDabo;

  String userName;
  String date;

  @override
  void initState() {
    super.initState();
    futureDetialDabo = getFutureDaboReport(userName, date);
    // print(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColorDark,
      appBar: AppBar(
        title: Text('በቀን ${this.date}  ${this.userName} የስራው፤ '),
      ),
      body: 
      ListView(
      //   padding: EdgeInsets.all(10),
      //   shrinkWrap: true,
        children: [
      //     AnimatedContainer(
      //       duration: Duration(seconds: 10),
      //       child: Text(this.date),
      //     ),
       Divider(
            thickness: 2,
          ),
          Utility.getDaboDetailReport(context, futureDetialDabo, date),
          Divider(
            thickness: 2,
          ),
        ],
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: Icon(Icons.edit_outlined),
      ),
    );
  }
}
