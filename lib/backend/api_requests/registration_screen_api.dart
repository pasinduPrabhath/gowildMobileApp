import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Screens/registartion_screen/registration_screen_model.dart';

class Api {
  static const baseUrl = 'https://example.com/api';

  static Future<int> createUser(User user) async {
    final url = Uri.parse('$baseUrl/users');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(user.toMap());

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 201) {
      return json.decode(response.body)['id'];
    } else {
      throw Exception('Failed to create user');
    }
  }
}
