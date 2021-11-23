// import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

class GetFromDB {
  static Future<List> getStudentDate() async {
    Uri uri = Uri.parse("http://192.168.1.4/student_json/routes.php");
    var response =
        await http.post(uri, body: {'action': 'get'});
    /**
     * if you have no condition to select data from your database put it in body section like 
     * below
      var response = await http.post(uri, body: {'action':'get'});
     * 
     */
    List selectedData;
    if (response.statusCode == 200) {
      selectedData = json.decode(response.body) as List;
    }
    return selectedData;
  }
}
