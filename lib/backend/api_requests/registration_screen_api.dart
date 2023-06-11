import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import '../../Screens/registartion_screen/registration_screen_model.dart';
import '../../Screens/login_screen/login_screen_model.dart';
import '../../Screens/admin/dashboard_screen.dart';

class Api {
  static const baseUrl = 'https://gowild.herokuapp.com/api';

  static Future<int> createUser(User user) async {
    final url = Uri.parse('$baseUrl/user/register');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(user.toMap());
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body)['success'];
    } else {
      throw Exception('Failed to create user');
    }
  }

  static Future<Map<String, dynamic>> loginUser(UserLogin user) async {
    final url = Uri.parse('$baseUrl/user/login');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(user.toMap());
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return {'success': data['success'], 'role': data['role']};
    } else {
      throw Exception('Failed to login user');
    }
  }

  static Future<int> numberOfRegisteredUsers() async {
    final url = Uri.parse('$baseUrl/user/totalUsers');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body)['userCount'];
    } else {
      throw Exception('Failed to get number of registered users');
    }
  }
}
