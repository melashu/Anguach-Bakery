import 'package:dabo/utility-lib/Utility.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PayementUpdate {
  static Future<bool> updatePayement(
      double oldPaiedBirr,
      double oldUnPaidBirr,
      double newPaidBirr,
      String date,
      String place,
      String userName,
      ) async {
    String approval = 'Waiting';
    var body = {
      'userName': userName,
      'date': date,
      'place': place,
      'paidBirr': oldPaiedBirr + newPaidBirr,
      'unPaidBirr': oldUnPaidBirr - newPaidBirr,
      'approval': approval,
      'action': 'UPDATE_PAY'
    };
    var url = Uri.parse("https://keteraraw.com/dabo/index.php");
    var result = await http.post(url, body: body);
    // print("meshu");
    if (result.body == 'ok') {
      return true;
    } else {
      // print("Status= ${result.body}");
      return false;
    }
  }
}
