import 'dart:convert';

import 'package:dabo/utility-lib/Utility.dart';

class DateModel {
  String date;
  DateModel({this.date});

  List<DateModel> getDate(String data) {
    List<DateModel> newDate;
    // print("Date===$data");
    var dateJson = json.decode(data) as List;
    newDate = dateJson.map((e) {
      return DateModel.fromJson(e);
    }).toList();
    newDate.add(DateModel(date: Utility.initDate));
    return newDate;
  }

  factory DateModel.fromJson(dynamic data) {
    return DateModel(date: data['date']);
  }
}
