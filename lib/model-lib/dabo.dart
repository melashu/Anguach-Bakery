import 'dart:convert';

class Dabo {
  String userName;
  String date;

  List<Dabo> getListOfDabo(String data) {
    List<Dabo> allDabo;
    var newMap = json.decode(data) as List;
    allDabo = newMap.map((obj) {
      return Dabo.fromMap(obj);
    }).toList();
    return allDabo;
  }

  Dabo({this.date, this.userName});
  factory Dabo.fromMap(Map<String, dynamic> daboList) {
    return Dabo(date: daboList['date'], userName: daboList['userName']);
  }
}
