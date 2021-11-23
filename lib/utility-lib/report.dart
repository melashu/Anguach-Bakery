import 'package:dabo/utility-lib/HttpRequest.dart';
import 'package:dabo/model-lib/dabo.dart';
import 'package:dabo/utility-lib/Utility.dart';
import 'package:flutter/material.dart';


class ReportHome extends StatefulWidget {
  ReportHome(this.userName);
  final String userName;

  @override
  State<StatefulWidget> createState() {
    return GetScaffold(this.userName);
  }
}
class GetScaffold extends State<ReportHome> {
  final String userName;
  String initDate = Utility.initDate;

  static Future<List<Dabo>> futureDabo;

  static Future<List<Dabo>> get getFuture {
    return futureDabo;
  }

  @override
  void initState() {
    super.initState();

    futureDabo = getListOfDabo(this.userName);
  }

  GetScaffold(this.userName);
  // initState
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('አጠቃላይ የዳቦ ሪፖርቶችን የሚታይበት ገጽ'), actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(Icons.replay_rounded),
            onPressed: () {
              setState(() {
                futureDabo = getListOfDabo(userName);
              });
            },
          ),
        )
      ]),
      body: Utility.getFrontListReport(context, futureDabo),
    
    
    );
  }
}
