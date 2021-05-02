import 'package:dabo/user-lib/payement.dart';
import 'package:dabo/utility-lib/HttpRequest.dart';
import 'package:dabo/model-lib/dabo.dart';
import 'package:dabo/user-lib/login.dart';
import 'package:dabo/user-lib/return.dart';
import 'package:dabo/utility-lib/Utility.dart';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'AddDabo.dart';

// class Home extends StatefulWidget {
//   final String userName;
//   Home(this.userName);
//   @override
//   _HomeState createState() => _HomeState(userName);
//   // initSta
// }

// class _HomeState extends State<Home> {
//   String userName;
//   static Future<List<Dabo>> futureDabo;
//   _HomeState(this.userName);

//   static Future<List<Dabo>> get getFuture {
//     return futureDabo;
//   }

// // ignore: slash_for_doc_comments
// /**
//     getListOfDabo(userName);
//  * is defined inside GetDaboList.dart file
//  */
//   @override
//   void initState() {
//     super.initState();

//     futureDabo = getListOfDabo(userName);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Anguach Dabo',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           accentColor: Colors.redAccent,
//           // bri
//         ),
//         home: HomeScaffold(userName));
//     // return getScaffold();
//   }
// }

class Home extends StatefulWidget {
  Home(this.userName);
  final String userName;

  @override
  State<StatefulWidget> createState() {
    return GetScaffold(this.userName);
  }
}

class GetScaffold extends State<Home> {
  final String userName;
    String initDate = Utility.initDate;

  static Future<List<Dabo>> futureDabo;

  static Future<List<Dabo>> get getFuture {
    return futureDabo;
  }

  @override
  void initState() {
    super.initState();

    futureDabo = getListOfDabo(userName);
  }

  GetScaffold(this.userName);
  // initState
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$userName'), actions: [
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
      body: Utility.getFrontList(context, futureDabo),
      drawer: getUserDrawer(context),
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
      ),
    );
  }

  Drawer getUserDrawer(BuildContext c) {
    return Drawer(
      elevation: 10,
      child: ListView(
        children: [
          DrawerHeader(
              child: UserAccountsDrawerHeader(
                  accountName:
                      Text('*${this.userName.toUpperCase()}* እንኮን ደህና መጣህ'),
                  accountEmail: Text('Anguach Dabo'))),
          Card(
            elevation: 10,
            margin: EdgeInsets.all(5),
            child: ListTile(
              title: Text(
                'ዳቦ መዝግብ ',
                style: Utility.textStyle,
              ),
              onTap: () {
                Navigator.push(c, MaterialPageRoute(builder: (context) {
                  return Body(userName: this.userName);
                })).then((value) {
                  setState(() {
                    // futureDabo = getListOfDabo(userName);
                  });
                });
                return LinearProgressIndicator();
              },
            ),
          ),
          Card(
            elevation: 10,
            margin: EdgeInsets.all(5),
            child: ListTile(
              title: Text(
                'ተመላሽ ዳቦ መመዝገቢያ',
                style: Utility.textStyle,
              ),
              onTap: () {
                Navigator.push(c, MaterialPageRoute(builder: (context) {
                  return ReturnDabo(userName: this.userName);
                }));
              },
            ),
          ),
          Card(
            elevation: 10,
            margin: EdgeInsets.all(5),
            child: ListTile(
              title: Text(
                'ሒሳብ መክፈያ',
                style: Utility.textStyle,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Payement(this.userName, this.initDate);
                }));
              },
            ),
          ),
          Card(
            elevation: 10,
            margin: EdgeInsets.all(5),
            child: ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'ወጣ',
                style: Utility.textStyle,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Login();
                }));
              },
            ),
          )
        ],
      ),
    );
  }
}
