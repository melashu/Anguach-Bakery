import 'package:dabo/admin-lib/debt.dart';
import 'package:dabo/admin-lib/salary.dart';
import 'package:dabo/user-lib/AddDabo.dart';
import 'package:dabo/user-lib/payement.dart';
import 'package:dabo/utility-lib/HttpRequest.dart';
import 'package:dabo/model-lib/dabo.dart';
import 'package:dabo/user-lib/login.dart';
import 'package:dabo/utility-lib/Utility.dart';
import 'package:dabo/utility-lib/report.dart';
import 'package:flutter/material.dart';
import 'employee.dart';

// import 'AddDabo.dart';
class AdminHome extends StatefulWidget {
  AdminHome({this.userName});
  final String userName;

  @override
  State<StatefulWidget> createState() {
    return GetScaffold(this.userName);
  }
}

class GetScaffold extends State<AdminHome> {
  final String userName;
  String initDate = Utility.initDate;
  int itemCount = 0;
  static Future<List<Dabo>> futureDabo;

  static Future<List<Dabo>> get getFuture {
    return futureDabo;
  }

  @override
  void initState() {
    super.initState();

    futureDabo = getListOfDabo('all');
    getNewPayement();
  }

  GetScaffold(this.userName);
  // initState
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [Text("Notifaction"), Text('result')],
      appBar: AppBar(title: Text('$userName'.toUpperCase()), actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: Icon(Icons.replay_rounded),
            onPressed: () {
              setState(() {
                futureDabo = getListOfDabo('all');
              });
            },
          ),
        )
      ]),
      body: RefreshIndicator(
          onRefresh: () {
            Utility.getFrontList(context, futureDabo);
          },
          child: Utility.getFrontList(context, futureDabo)),
      drawer: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          child: getUserDrawer(context)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Body(
              userName: this.userName,
            );
          })).then((value) {
            setState(() {
              futureDabo = getListOfDabo('all');
            });
          });
        },
        tooltip: 'Payement',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget getUserDrawer(BuildContext c) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.white10,
        child: Drawer(
          elevation: 10,
          child: ListView(
            children: [
              DrawerHeader(
                  child: UserAccountsDrawerHeader(
                      accountName:
                          Text('*${this.userName.toUpperCase()}* እንኳን ደህና መጣህ'),
                      accountEmail: Text('Anguach Dabo'))),
              ExpansionTile(
                title: Text('Report'),
                children: [
                  ExpansionTile(
                    title: Text('Financial Report'),
                    // subtitle: Text('Daily, Weekliy and Monthly Report'),
                    expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                    childrenPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    children: [
                      Card(
                        child: ListTile(
                          title: Text('Daily Report'),
                          trailing: Icon(Icons.report_outlined),
                          onTap: () {},
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Weekliy Report'),
                          trailing: Icon(Icons.report_outlined),
                          onTap: () {},
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text('Monthliy Report'),
                          trailing: Icon(Icons.report_outlined),
                          onTap: () {},
                        ),
                      )
                    ],
                  )
                ],
                childrenPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                backgroundColor: Colors.white,
                subtitle: Text('Payement Related Operation'),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                // initiallyExpanded: true,
                onExpansionChanged: (value) {},
              ),

              ExpansionTile(
                title: Text('Payement'),
                children: [
                  Card(
                    elevation: 10,
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      title: Text(
                        'Make Payement',
                        style: Utility.textStyle,
                      ),
                      onTap: () {
                        Navigator.push(c, MaterialPageRoute(builder: (context) {
                          return Payement('all', this.initDate);
                        })).then((value) {
                          setState(() {
                            futureDabo = getListOfDabo('all');
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
                        'Payement Notification ',
                        style: Utility.textStyle,
                      ),
                      // trailing: Text('new'),
                      onTap: () {
                        Navigator.push(c, MaterialPageRoute(builder: (context) {
                          // return Body(userName: this.userName);
                        }))
                            .then((value) {
                          setState(() {
                            // futureDabo = getListOfDabo('all');
                          });
                        });
                        return LinearProgressIndicator();
                      },
                      subtitle: Text(
                        '$itemCount new Payement waiting for approval',
                        style: TextStyle(
                            color: itemCount != 0 ? Colors.red : Colors.green),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 10,
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      title: Text(
                        'List of Payement ',
                        style: Utility.textStyle,
                      ),
                      subtitle: Text('List of pre-made payement'),
                      onTap: () {
                        Navigator.push(c, MaterialPageRoute(builder: (context) {
                          // return Body(userName: this.userName);
                        }))
                            .then((value) {
                          setState(() {
                            // futureDabo = getListOfDabo('all');
                          });
                        });
                        return LinearProgressIndicator();
                      },
                    ),
                  ),
                ],
                childrenPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                backgroundColor: Colors.white,

                subtitle: Text('Payement Related Operation'),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                // initiallyExpanded: true,
                onExpansionChanged: (value) {},
              ),

              ExpansionTile(
                title: Text('Employe'),
                subtitle: Text('Employe and Debt Related'),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                backgroundColor: Colors.white,
                childrenPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                children: [
                  Card(
                    elevation: 10,
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      title: Text(
                        'Register Employee  ',
                        style: Utility.textStyle,
                      ),
                      // trailing: Text('new'),
                      onTap: () {
                        Navigator.push(c, MaterialPageRoute(builder: (context) {
                          return Employee();
                          // return Body(userName: this.userName);
                        })).then((value) {
                          setState(() {
                            // futureDabo = getListOfDabo('all');
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
                        'Salary',
                        style: Utility.textStyle,
                      ),
                      // trailing: Text('new'),
                      onTap: () {
                        Navigator.push(c, MaterialPageRoute(builder: (context) {
                          return Salary();
                        })).then((value) {
                          setState(() {
                            // futureDabo = getListOfDabo('all');
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
                        'Debt ',
                        style: Utility.textStyle,
                      ),
                      // trailing: Text('new'),
                      onTap: () {
                        Navigator.push(c, MaterialPageRoute(builder: (context) {
                          return Debt();
                        }));

                        return LinearProgressIndicator();
                      },
                    ),
                  )
                ],
              ),
              ExpansionTile(
                title: Text('Resource & Product'),
                subtitle: Text('Avaliable resource and Product'),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                backgroundColor: Colors.white,
                childrenPadding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                children: [
                  Card(
                    elevation: 10,
                    margin: EdgeInsets.all(5),
                    child: ListTile(
                      title: Text(
                        'Register Resource  ',
                        style: Utility.textStyle,
                      ),
                      // trailing: Text('new'),
                      onTap: () {
                        Navigator.push(c, MaterialPageRoute(builder: (context) {
                          // return Body(userName: this.userName);
                        }))
                            .then((value) {
                          setState(() {
                            // futureDabo = getListOfDabo('all');
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
                        'Daily Used Resource',
                        style: Utility.textStyle,
                      ),
                      subtitle: Text('It includes how many bread is made'),
                      // trailing: Text('new'),
                      onTap: () {
                        Navigator.push(c, MaterialPageRoute(builder: (context) {
                          // return Body(userName: this.userName);
                        }))
                            .then((value) {
                          setState(() {
                            // futureDabo = getListOfDabo('all');
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
                        'Daily Predication',
                        style: Utility.textStyle,
                      ),
                      subtitle: Text('It predict how much kg is required'),
                      // trailing: Text('new'),
                      onTap: () {
                        Navigator.push(c, MaterialPageRoute(builder: (context) {
                          // return Body(userName: this.userName);
                        }))
                            .then((value) {
                          setState(() {
                            // futureDabo = getListOfDabo('all');
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
                        'Debt   ',
                        style: Utility.textStyle,
                      ),
                      // trailing: Text('new'),
                      onTap: () {
                        Navigator.push(c, MaterialPageRoute(builder: (context) {
                          // return Body(userName: this.userName);
                        }))
                            .then((value) {
                          setState(() {
                            // futureDabo = getListOfDabo('all');
                          });
                        });
                        return LinearProgressIndicator();
                      },
                    ),
                  )
                ],
              ),
              Card(
                elevation: 10,
                margin: EdgeInsets.all(5),
                child: ListTile(
                  title: Text(
                    'Reports',
                    style: Utility.textStyle,
                  ),
                  onTap: () {
                    Navigator.push(c, MaterialPageRoute(builder: (context) {
                      return ReportHome('all');
                    }));
                  },
                ),
              ),

              // Card(
              //   elevation: 10,
              //   margin: EdgeInsets.all(5),
              //   child: ListTile(
              //     title: Text(
              //       'ሪፖርት',
              //       style: Utility.textStyle,
              //     ),
              //     onTap: () {
              //       Navigator.push(context, MaterialPageRoute(builder: (context) {
              //         // return Payement(this.userName, this.initDate);
              //         return ReportHome('all');

              //       }));
              //     },
              //   ),
              // ),

              // Card(
              //   elevation: 10,
              //   margin: EdgeInsets.all(5),
              //   child: ListTile(
              //     title: Text(
              //       'ንብረት',
              //       style: Utility.textStyle,
              //     ),
              //     onTap: () {
              //       Navigator.push(context, MaterialPageRoute(builder: (context) {
              //         // return Payement(this.userName, this.initDate);
              //       }));
              //     },
              //   ),
              // ),

              Card(
                elevation: 10,
                margin: EdgeInsets.all(5),
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text(
                    'Logout',
                    style: Utility.textStyle,
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Login();
                    }));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void getNewPayement() {
    getNewPayementNotification().then((value) {
      setState(() {
        itemCount = value;
      });
    });
  }
}
