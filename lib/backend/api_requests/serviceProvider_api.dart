import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../Screens/navigationbar_screens/profile_screen/clientProfileView/firstPersonView/profile_screen_model.dart';

class SpAPI {
  static const baseUrl = 'https://gowild.herokuapp.com/api';
  static Future<int> updateCalender(
      String? email, String? date, String? eventDetails) async {
    final url = Uri.parse('$baseUrl/serviceProvider/addEventToCalendar');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(
        {'email': email, 'eventDate': date, 'eventDetails': eventDetails});
    print(body);

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == 1) {
        return data['data']['insertId'];
      } else {
        throw Exception('Failed to add event to calendar');
      }
    } else {
      throw Exception('Failed to load profile details');
    }
  }

  static Future<List<dynamic>> getCalender(
      String? email, String? date, String? eventDetails) async {
    final url = Uri.parse('$baseUrl/serviceProvider/getCalendarEvents');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(
        {'email': email, 'startDate': '2020-06-01', 'endDate': '2300-12-31'});
    print(body);

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['success'] == 1) {
        return data['data'];
      } else {
        throw Exception('Failed to add event to calendar');
      }
    } else {
      throw Exception('Failed to load profile details');
    }
  }
}
