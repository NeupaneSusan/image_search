
import 'package:http/http.dart' as http;
class ApiController {
  static Future<http.Response> getMethodWithOutToken(Uri url) async {
    final response = await http.get(url);
    return response;
  }
}