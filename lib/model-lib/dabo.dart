import 'dart:convert';

class Dabo {
  String userName;
  String date;
  String place;
  List<Dabo> getListOfDabo(String data) {
    List<Dabo> allDabo;
    var newMap = json.decode(data) as List;
    allDabo = newMap.map((obj) {
      return Dabo.fromMap(obj);
    }).toList();
    return allDabo;
  }

  ///
  ///getListOfPlace: used to get list of each working
  ///place for editing purpose
  ///
  List<Dabo> getListOfPlace(String data) {
    List<Dabo> allDabo;
    var newMap = json.decode(data) as List;
    allDabo = newMap.map((obj) {
      return Dabo.fromMapPlace(obj);
    }).toList();
    return allDabo;
  }

  Dabo({this.date, this.userName, this.place});
  factory Dabo.fromMap(Map<String, dynamic> daboList) {
    return Dabo(date: daboList['date'], userName: daboList['userName']);
  }

////
///fromMapPlace(): this named constractor is used 
///to return an object with place
///
  factory Dabo.fromMapPlace(dynamic placeList) {
    return Dabo(date: placeList['date'], place: placeList['place'],userName: placeList['userName']);
  }
}
