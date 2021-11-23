import 'dart:convert';
import 'package:abushakir/abushakir.dart';
import 'package:dabo/admin-lib/AdminHome.dart';
import 'package:dabo/admin-lib/debt.dart';
import 'package:dabo/user-lib/Home.dart';
import 'package:dabo/utility-lib/Utility.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      // EtDatetime dt = EtDatetime.now();
    // debugPrint("dt");
    return MaterialApp(
        title: 'Anguach Mobile',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // primarySwatch: Colors.blue[],
          accentColor: Colors.blueAccent,
          primaryColor: Colors.blueAccent,
          // brightness: Brightness.dark
        ),
        home: LoginPage()
          
        );
        
        //LoginPage()
        // );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<LoginPage> {
  var formKey = GlobalKey<FormState>();
  var userNameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
        centerTitle: true,
      ),
      // backgroundColor: Colors.blueGrey,
      body: Center(
        // heightFactor: ,
        child: Container(
          color: Colors.white10,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: ListView(
              // padding: EdgeInsets.only(top: 120),
              shrinkWrap: true,
              children: [
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: userNameController,
                  autocorrect: true,
                  validator: (String val) {
                    if (val.isEmpty) {
                      return 'Please enter user name';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.account_circle_outlined),
                      labelText: AutofillHints.username,
                      labelStyle: TextStyle(color: Colors.blue),
                      hintText: 'E.g. Sol',
                      hintStyle: TextStyle(color: Colors.blue),
                      border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  controller: passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  validator: (String val) {
                    if (val.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.vpn_key_outlined),
                    labelText: 'Password',
                    hintStyle: TextStyle(color: Colors.blue),
                    labelStyle: TextStyle(color: Colors.blue),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        // style: ButtonStyle.,
                        onPressed: () {
                          
                          setState(() {
                            if (formKey.currentState.validate()) {
                              // return CircularProgressIndicator();

                              loginPageController(context);
                            }
                          });
                        },
                        child: Text('Login'),
                      ),
                    ),
                    Expanded(
                        child: TextButton(
                            onPressed: () {}, child: Text('Forgot Password')))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginPageController(BuildContext context) async {
    String userName = userNameController.text;
    String password = passwordController.text;

    Utility.showAlertDialog(context, 'ትንሽ ጠብቅ ');
    // return Container(child: LinearProgressIndicator());
    LoginModel loginModel = await loginFuture(userName, password, context);
    if (loginModel.role.toLowerCase() == 'admin'.toLowerCase()) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AdminHome(userName: userName);
      }));
    } else if (loginModel.role.toLowerCase() == 'user'.toLowerCase()) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return Home(userName);
      }));
    }
    // }
    // } else {
    //   Utility.showSnakBar(
    //       "Something went wrong! Please call to ***0980631983***",
    //       context,
    //       Colors.redAccent);
  }
}

class LoginModel {
  String role;
  LoginModel({this.role});
  factory LoginModel.fromJson(dynamic json) {
    return LoginModel(role: json['role']);
  }
}

Future<LoginModel> loginFuture(
    String userName, String password, BuildContext context) async {
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var response = await http.post(uri,
      body: {'userName': userName, 'password': password, 'action': 'LOGIN'});
  if (response.statusCode == 200) {
    if (response.body == 'empty') {
      Utility.showSnakBar(
          "Username ወይም password ተሳስትሃል፡፡ ", context, Colors.redAccent);
    } else {
      // print(response.body.toString());
      var toJson = json.decode(response.body) as List;
      // print("Result=${toJson['role']}");
      return LoginModel.fromJson(toJson[0]);
    }
  } else {
    Utility.showSnakBar(
        "Something went wrong! Please call to ***0980631983*** ${response.body}",
        context,
        Colors.redAccent);
  }
}
