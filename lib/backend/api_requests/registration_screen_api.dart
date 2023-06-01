import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Screens/registartion_screen/registration_screen_model.dart';

class Api {
  static const baseUrl = 'https://gowild.herokuapp.com/api';

  static Future<int> createUser(User user) async {
    final url = Uri.parse('$baseUrl/user/register');
    final headers = {'Content-Type': 'application/json'};
    // print(user.toMap());
    final body = json.encode(user.toMap());
    print(body);
    final response = await http.post(url, headers: headers, body: body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      // print('called');
      return json.decode(response.body)['success'];
    } else {
      throw Exception('Failed to create user');
    }
  }
}
