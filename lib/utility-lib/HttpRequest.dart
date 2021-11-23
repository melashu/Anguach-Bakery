import 'dart:convert';

import 'package:dabo/model-lib/DetailDabo.dart';
import 'package:dabo/model-lib/date_model.dart';
import 'package:dabo/model-lib/payement_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
// import 'dart:';
import '../model-lib/dabo.dart';
import 'Utility.dart';

Future<List<Dabo>> getListOfDabo(String userName) async {
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var response =
      await http.post(uri, body: {'userName': userName, 'action': 'GET_TASK'});
  // print(response.statusCode);
  return Dabo().getListOfDabo(response.body);
}

Future<List<DetailDabo>> getDetailDabo(String userName, String date) async {
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var response = await http.post(uri,
      body: {'userName': userName, 'date': date, 'action': 'GET_DABO'});
  print(response.body);
  return DetailDabo().getDetailOfDabo(response.body);
}

Future<List<PayementModel>> futurePayementModel(
    String userName, String date, String place) async {
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var response = await http.post(uri, body: {
    'userName': userName,
    'date': date,
    'place': place,
    'action': 'PAYEMENT'
  });
  return PayementModel().ListOfPayement(response.body);
}

/// For geting the last inserted 5 date
///

Future<List<DateModel>> futureDateModel(String userName) async {
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var response = await http
      .post(uri, body: {'userName': userName, 'action': 'GETTING_DATE'});
  return DateModel().getDate(response.body);
}

Future<List<DetailDabo>> getFutureDaboReport(
    String userName, String date) async {
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var response = await http.post(uri,
      body: {'userName': userName, 'date': date, 'action': 'GET_DABO'});
  // print(response.body);
  return DetailDabo().getDetailOfDabo(response.body);
}

Future<List<Dabo>> getListOfPlace(
    String userName, String date, BuildContext context) async {
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var response = await http.post(uri,
      body: {'userName': userName, 'date': date, 'action': 'GET_FOR_EDITTING'});
  if (response.body == 'empty') {
    Utility.showSnakBar(
        "ይቅርታ ከዚህ በፊት የተመዘገበ ነገር የለም", context, Colors.redAccent);
  } else {
    return Dabo().getListOfPlace(response.body);
  }
}

Future<bool> deleteDabo(String userName, String place, String date) async {
  // print("$userName and $place ande $date");
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var response = await http.post(uri, body: {
    'userName': userName,
    'date': date,
    'place': place,
    'action': 'DEL_DABO'
  });
  // print('Result=${response.body}');
  if (response.body == 'ok') {
    return true;
  } else {
    return false;
  }
}

Future<String> addEmploye(dynamic employee) async {
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var response = await http.post(uri, body: employee);
  if (response.body == 'ok') {
    return 'ok';
  } else {
    return response.body;
  }
}

Future<String> updateEmploye(dynamic employee) async {
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var response = await http.post(uri, body: employee);
  if (response.body == 'ok') {
    return 'ok';
  } else {
    return response.body;
  }
}

Future<String> addDebt(dynamic debt) async {
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var response = await http.post(uri, body: debt);
  if (response.body == 'ok') {
    return 'ok';
  } else {
    return response.body;
  }
}

Future<int> getNewPayementNotification() async {
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var response = await http.post(uri, body: {'action': 'GET_COUNT'});
  var list = jsonDecode(response.body) as List;
  var count = list[0]['id'];
  // print(" data= $count");

  if (response.body != 'empty') {
    return int.parse(count);
  } else {
    return 0;
  }
}

Future<String> getDebt() async {
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var re = await http.post(uri, body: {'action': 'GET_DEBT'});
  // print("data=="+ re.body);
  return re.body;
}

Future<String> getEmp() async {
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var re = await http.post(uri, body: {'action': 'GET_EMP'});
  // print("data=="+ re.body);
  return re.body;
}

Future<String> delEmp(String id) async {
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var re = await http.post(uri, body: {'empID': id, 'action': 'DEL_EMP'});
  return re.body;
}

Future<bool> addReturnDebt(
    String today, String empID, String left, String status) async {
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var re = await http.post(uri, body: {
    'today': today,
    'empID': empID,
    'left': left,
    'status': status,
    'action': 'ADD_RETURN_DEBT'
  });
  // print("Result==${re.body}");
  if (re.body == 'ok')
    return true;
  else
    return false;
}

Future<String> getSalary() async {
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var re = await http.post(uri, body: {'action': 'GET_SALA'});
  return re.body;
}

Future<String> paySalary(Map <String,String> map ) async {
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var re = await http.post(uri, body: map);
  return re.body;
}
