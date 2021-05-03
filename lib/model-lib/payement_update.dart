import 'package:dabo/utility-lib/Utility.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PayementUpdate {
  static Future<bool> updatePayement(
      double oldPaiedBirr,
      double oldUnPaidBirr,
      String newPaid,
      String date,
      String place,
      String userName,
      BuildContext context) async {
    String status = 'ያልጸደቀ';

    double newPaidBirr = double.parse(newPaid);
    if (newPaidBirr > oldUnPaidBirr) {
      Utility.showSnakBar(
          "ያለብህ እዳ $oldUnPaidBirr ብር ሲሆን ያስግባክው ግን $newPaidBirr ብር ነው፡፡",
          context,
          Colors.red[400]);
    } else {
      var body = {
        'userName': userName,
        'date': date,
        'place': place,
        'paidBirr': (oldPaiedBirr + newPaidBirr).toString(),
        'unPaidBirr': (oldUnPaidBirr - newPaidBirr).toString(),
        'status': status,
        'action': 'UPDATE_PAY'
      };
      var url = Uri.parse("https://keteraraw.com/dabo/index.php");
      var result = await http.post(url, body: body);
      // print('Result=${result.body}');
      if (result.body == 'ok') {
        return true;
      } else {
        // print("Status= ${result.body}");
        return false;
      }
    }
  }
}
