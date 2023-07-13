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

  static Future<int> updateUserPostPicture(
      String email, String postPicture) async {
    final url = Uri.parse('$baseUrl/user/uploadPicture');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'email': email, 'postPicture': postPicture});
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

  static Future<List<String>> getImages(String email) async {
    final url = Uri.parse('$baseUrl/user/getUploadedPictures');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'email': email});

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final result = jsonResponse['data']
          .map((item) => item['url'])
          .cast<String>()
          .toList();
      return result;
    }
    if (response.statusCode == 400) {
      return json.decode(response.body)['username'];
    } else {
      throw Exception('Failed to check username');
    }
  }

  static Future<List> searchUsers(String query) async {
    final url = Uri.parse('$baseUrl/user/getSearchResult');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'search': query});

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final result = jsonResponse['data'] as List<dynamic>;
      return result;
    }
    if (response.statusCode == 400) {
      return json.decode(response.body)['username'];
    } else {
      throw Exception('Failed to check username');
    }
  }

  static Future<bool> followUser(
      String followerEmail, String followingEmail) async {
    final url = Uri.parse('$baseUrl/user/followUser');
    final headers = {'Content-Type': 'application/json'};
    final body =
        json.encode({'email': followerEmail, 'followingEmail': followingEmail});

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body)['isFollowing'];
    }
    if (response.statusCode == 400) {
      return json.decode(response.body)['username'];
    } else {
      throw Exception('Failed to check username');
    }
  }

  static Future<bool> unfollowUser(
      String followerEmail, String followingEmail) async {
    final url = Uri.parse('$baseUrl/user/unfollowUser');
    final headers = {'Content-Type': 'application/json'};
    final body =
        json.encode({'email': followerEmail, 'followingEmail': followingEmail});

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body)['isFollowing'];
    }
    if (response.statusCode == 400) {
      return json.decode(response.body)['username'];
    } else {
      throw Exception('Failed to check username');
    }
  }

  static Future<bool> getFollowerStatus(
      String followerEmail, String followingEmail) async {
    final url = Uri.parse('$baseUrl/user/getFollowerStatus');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(
        {'followerEmail': followerEmail, 'followingEmail': followingEmail});

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body)['followStatus'];
    }
    if (response.statusCode == 500) {
      return json.decode(response.body)['message'];
    } else {
      throw Exception('Failed to check username');
    }
  }

  static Future<int> getFollowerCount(String followerEmail) async {
    final url = Uri.parse('$baseUrl/user/getFollowerCount');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'email': followerEmail});

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'][0]['count'];
    }
    if (response.statusCode == 500) {
      return json.decode(response.body)['message'];
    } else {
      throw Exception('Failed to check username');
    }
  }

  static Future<int> getFollowingCount(String followerEmail) async {
    final url = Uri.parse('$baseUrl/user/getFollowingCount');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'email': followerEmail});

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return json.decode(response.body)['data'][0]['count'];
    }
    if (response.statusCode == 500) {
      return json.decode(response.body)['message'];
    } else {
      throw Exception('Failed to check username');
    }
  }
}
