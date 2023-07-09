import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../Screens/navigationbar_screens/profile_screen/profile_screen_model.dart';

class ClientAPI {
  static const baseUrl = 'https://gowild.herokuapp.com/api';
  List<String> name = [];

  static Future<List<Profile>> getUserProfileDetails(String email) async {
    final url = Uri.parse('$baseUrl/user/getUserDetailsForProfile');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'email': email});

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final result = jsonResponse['data']
          .map<Profile>((json) => Profile.fromJson(json))
          .toList();

      return result;
    }
    if (response.statusCode == 400) {
      return json.decode(response.body)['username'];
    } else {
      throw Exception('Failed to check username');
    }
  }

  static Future<int> updateUserProfilePicture(
      String email, String profilePicture) async {
    final url = Uri.parse('$baseUrl/user/updateProfilePicture');
    final headers = {'Content-Type': 'application/json'};
    final body =
        json.encode({'email': email, 'profilePicture': profilePicture});
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body)['success'];
    }
    if (response.statusCode == 500) {
      final message = json.decode(response.body)['message'];
      if (message == 'Database connection error') {
        throw Exception('Server error, Please try again later');
      }
    } else {
      throw Exception('Failed to create user');
    }
    throw Exception('Failed to create user');
  }
}
