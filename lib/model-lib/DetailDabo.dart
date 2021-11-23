import 'dart:convert';

class DetailDabo {
  String place;
  String bale_2_25;
  String bale_2_5;
  String bale_3;
  String bale5;
  String bale10;
  String bale75;
  String bale100;
  String bale120;
  String bale150;
  String bale200;
  String paidBirr;
  String unPaidBirr;
  String status;
  String approval;
  String date;
  // String
  DetailDabo(
      {this.bale_2_25,
      this.bale_2_5,
      this.bale_3,
      this.bale5,
      this.bale10,
      this.bale75,
      this.bale100,
      this.bale120,
      this.bale150,
      this.bale200,
      this.place,
      this.paidBirr,
      this.unPaidBirr,
      this.status,
      this.approval,
      this.date});
  List<DetailDabo> getDetailOfDabo(String data) {
    List<DetailDabo> allDabo;
    var newMap = json.decode(data) as List;
    allDabo = newMap.map((obj) {
      return DetailDabo.fromMap(obj);
    }).toList();
    return allDabo;
  }

  factory DetailDabo.fromMap(dynamic json) {
    return DetailDabo(
        bale_2_25: json['bale_2_25'],
        bale_2_5: json['bale_2_5'],
        bale_3: json['bale_3'],
        bale5: json['bale_5'],
        bale10: json['bale_10'],
        bale75: json['bale_75'],
        bale100: json['bale_100'],
        bale120: json['bale_120'],
        bale150: json['bale_150'],
        bale200: json['bale_200'],
        place: json['place'],
        paidBirr: json['paidBirr'],
        unPaidBirr: json['unPaidBirr'],
        status: json['status'],
        approval: json['approval'],
        date: json['date']);
  }
}
