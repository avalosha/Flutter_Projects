import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NetworkHelper {
  NetworkHelper();

  Future getData(Uri url) async {
    print(url);
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      return convert.jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
