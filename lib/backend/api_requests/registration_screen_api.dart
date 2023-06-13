import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import '../../Screens/registartion_screen/registration_screen_model.dart';
import '../../Screens/login_screen/login_screen_model.dart';
import '../../Screens/admin/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      final token = data['token'];
      print('Login successful: $data');

      SharedPreferences prefs = await SharedPreferences.getInstance();

      // if (prefs != null) {
      //   await prefs.setString('token', token);
      //   print('Token saved: $token');
      // } else {
      //   print('Failed to get SharedPreferences instance');
      // }
      return {
        'success': data['success'],
        'role': data['role'],
        'token': token,
      };
    } else if (response.statusCode == 401) {
      throw Exception('Invalid email or password');
    } else {
      throw Exception('Failed to login user: ${response.statusCode}');
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
