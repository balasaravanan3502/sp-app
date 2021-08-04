import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url = 'https://brilliantrev.com/digitaldairy/operator_api/';
  var client = http.Client();

  Future postMethod(String api, body) async {
    var response =
        await client.post(Uri.parse('$url$api'), body: jsonEncode(body));

    var data = response.body;
    return jsonDecode(data);
  }

  Future getMethod(String api) async {
    var response = await http.get(Uri.parse('$url$api'));

    if (response.statusCode == 200) {
      var data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
