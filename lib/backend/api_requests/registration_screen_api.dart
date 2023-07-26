import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import '../../Screens/registration_screen/registration_screen_model.dart';
import '../../Screens/login_screen/login_screen_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Screens/registration_screen/service_provider_model.dart';

class Api {
  static const baseUrl = 'https://gowild.herokuapp.com/api';

  static Future<int> createUser(User user) async {
    final url = Uri.parse('$baseUrl/user/registerClient');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(user.toMap());
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body)['success'];
    }
    if (response.statusCode == 400) {
      final message = json.decode(response.body)['message'];
      if (message == 'Email already exists') {
        throw Exception('Email already registered');
      }
    } else {
      throw Exception('Failed to create user');
    }
    throw Exception('Failed to create user');
  }

  static Future<String> checkEmailAvaialability(String? email) async {
    final url = Uri.parse('$baseUrl/user/checkExistingEmail');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'email': email});
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body)['message'];
    }
    if (response.statusCode == 400) {
      return json.decode(response.body)['message'];
    } else {
      throw Exception('Failed to check email');
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
      // final role = data['role'];
      // print('Login successful: $data');

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
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
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      return json.decode(response.body)['userCount'];
    } else {
      throw Exception('Failed to get number of registered users');
    }
  }

  static Future<int> registerServiceProvider(
      ServiceProvider serviceProvider) async {
    final url = Uri.parse('$baseUrl/serviceProvider/registerServiceProvider');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(serviceProvider.toMap());
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body)['success'];
    }
    if (response.statusCode == 400) {
      final message = json.decode(response.body)['message'];
      if (message == 'Email already exists') {
        throw Exception('Email already registered');
      }
    } else {
      throw Exception('Failed to create user');
    }
    throw Exception('Failed to create user');
  }

  static Future<int> uploadUserProfilePicture(String email, String urls) async {
    final url = Uri.parse('$baseUrl/user/setClientProfilePicture');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'email': email, 'profilePicture': urls});
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body)['success'];
    }
    if (response.statusCode == 400) {
      final message = json.decode(response.body)['message'];
      if (message == 'Email already exists') {
        throw Exception('Email already registered');
      }
    } else {
      throw Exception('Failed to create user');
    }
    throw Exception('Failed to create user');
  }
}
