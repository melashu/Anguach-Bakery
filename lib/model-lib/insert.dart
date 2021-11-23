import 'package:http/http.dart' as http;

class Insert {
  // static String ADD_DABO = 'ADD_DABO';
  static Future<bool> insertDabo(Map<String, dynamic> dabo) async {
    // var client = http.Client();
    var url = Uri.parse("https://keteraraw.com/dabo/index.php");
    var result = await http.post(url, body: dabo);
    // print("Result= ${result.body}");
    if (result.body == 'ok') {
      // print(result.body);
      return true;
      /****
       * 127.0.0.1:4098
       */
    } else {
      return false;
    }
  }
}
