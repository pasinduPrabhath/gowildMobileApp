import 'dart:convert';
// import 'dart:html';

import 'package:http/http.dart' as http;
import '../../Screens/navigationbar_screens/marketplace_screen/equipment_ads/marketPlaceAddModel.dart';
import '../../Screens/navigationbar_screens/profile_screen/clientProfileView/firstPersonView/profile_screen_model.dart';

class ClientAPI {
  static const baseUrl = 'https://gowild.herokuapp.com/api';
  // List<String> name = [];

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

  static Future<Map<String, dynamic>> getUserDetails(String email) async {
    final url = Uri.parse('$baseUrl/user/getUserDetails');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'email': email});

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      throw Exception('Failed to load profile details');
    }
  }

  static Future<int> deletePost(String email, String picurl) async {
    final url = Uri.parse('$baseUrl/user/deletePost');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'email': email, 'url': picurl});
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

  static Future<int> createMarketPlaceAd(
    MarketPlaceAdd marketPlaceAdd,
  ) async {
    final url = Uri.parse('$baseUrl/user/postAnAd');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode(marketPlaceAdd.toMap());
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
      throw Exception('Failed to Post Ad');
    }
    throw Exception('Failed to Post Ad');
  }

  static Future<List<dynamic>> getAds() async {
    final url = Uri.parse('$baseUrl/user/getAllAds');
    final headers = {'Content-Type': 'application/json'};
    // final body = json.encode(marketPlaceAdd.toMap());
    // final response = await http.post(url, headers: headers, body: body);
    final response = await http.get(url, headers: headers);
    // Uri.parse('$baseUrl/user/getAllAds'),

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to load ads');
    }
  }

  static Future<List<dynamic>> getSimpleUserDetails(int userID) async {
    final url =
        Uri.parse('https://gowild.herokuapp.com/api/user/getSimpleUserDetails');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'userId': userID});
    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to load user details');
    }
  }

  static Future<List<dynamic>> getUserAds(String email) async {
    final url = Uri.parse('$baseUrl/user/getUserAds');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'email': email});
    // final response = await http.post(url, headers: headers, body: body);
    final response = await http.post(url, headers: headers, body: body);
    // Uri.parse('$baseUrl/user/getAllAds'),

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to load ads');
    }
  }

  static Future<int> deleteMyAd(int adID) async {
    final url = Uri.parse('$baseUrl/user/deleteAd');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'adId': adID});
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

  static Future<List<dynamic>> getAdsByCategory(
      String category, String location) async {
    // if (category == null || category.isEmpty || category == 'All ads') {
    //   return getAds();
    // }
    // if (location == null || location.isEmpty || location == 'Location') {
    //   return getAds();
    // }
    final url = Uri.parse('$baseUrl/user/getAdsByCategory');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'category': category,
      'location': location,
    });
    // final response = await http.post(url, headers: headers, body: body);
    final response = await http.post(url, headers: headers, body: body);
    // Uri.parse('$baseUrl/user/getAllAds'),

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to load ads');
    }
  }

  static Future<List<dynamic>> getAdsByLocation(String location) async {
    if (location == null || location.isEmpty || location == 'Location') {
      return getAds();
    }
    final url = Uri.parse('$baseUrl/user/getAdsByLocation');
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'location': location});
    // final response = await http.post(url, headers: headers, body: body);
    final response = await http.post(url, headers: headers, body: body);
    // Uri.parse('$baseUrl/user/getAllAds'),

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return jsonResponse['data'];
    } else {
      throw Exception('Failed to load ads');
    }
  }
}
