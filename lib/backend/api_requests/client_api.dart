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
      // final serviceProviderList = jsonResponse['request']
      //     .map<ServiceProvider>((json) => ServiceProvider.fromJson(json))
      //     .toList();
      // return serviceProviderList;
    }
    if (response.statusCode == 400) {
      return json.decode(response.body)['username'];
    } else {
      throw Exception('Failed to check username');
    }
  }
}
