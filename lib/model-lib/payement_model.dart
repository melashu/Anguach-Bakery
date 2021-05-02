import 'dart:convert';

class PayementModel {
  String paidBirr;
  String unPaidBirr;
  PayementModel({this.paidBirr, this.unPaidBirr});

  List<PayementModel> ListOfPayement(String data) {
    List<PayementModel> payementList;
    // print('value=$data');
    var jsonData = json.decode(data) as List;

    payementList = jsonData.map((e) {
      return PayementModel.fromJson(e);
    }).toList();
    // payementList. 
    return payementList;
  }

  factory PayementModel.fromJson(dynamic json) {
    return PayementModel(
        paidBirr: json['paidBirr'], unPaidBirr: json['unPaidBirr']);
  }
}
