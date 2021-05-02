import 'package:dabo/model-lib/DetailDabo.dart';
import 'package:dabo/model-lib/date_model.dart';
import 'package:dabo/model-lib/payement_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
// import 'dart:';
import '../model-lib/dabo.dart';

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
  return DetailDabo().getDetailOfDabo(response.body);
}


Future<List<PayementModel>> futurePayementModel(String userName,String date,String place) async{
 Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var response = await http.post(uri,
      body: {'userName': userName, 'date': date,'place':place, 'action': 'PAYEMENT'});
  return PayementModel().ListOfPayement(response.body);

}


/// For geting the last inserted 5 date
/// 

Future<List<DateModel>> futureDateModel(
    String userName) async {
  Uri uri = Uri.parse("https://keteraraw.com/dabo/index.php");
  var response = await http.post(uri, body: {
    'userName': userName,
    'action': 'GETTING_DATE'
  });
  return DateModel().getDate(response.body);
}


