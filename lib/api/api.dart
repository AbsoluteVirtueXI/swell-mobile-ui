import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swell_mobile_ui/models/user.dart';

const BASE_URL = 'https://api.squarrin.com';


Future<bool> isRegistered (String ethereumAddress) async {
  var response = await  http.get('${BASE_URL}/is_registered/${ethereumAddress}');
  if(response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

Future<User> getUser(String eth) async {
  print('API CALL');
  var response = await http.get('${BASE_URL}/is_registered/${eth}');
  if(response.statusCode == 200) {
  Map userMap  = jsonDecode(response.body);
  var user = User.fromJson(userMap);
  return user;
  }else {
    throw Exception('Failed to call isREgistrered');
  }
}



/*
Future<int> getUserIdByUsername(String username) async {

}

Future<int> getUserIdByLogin(String login) async {

}

Future<String> uploadVideo() async {

}

Future<String> getNotifications() async {

}

Future<String> setLike() async {

}

Future<String> getAllMyVideosUrl() async {

}

Future<List<String> getAllVideosUrl() async {

}

Future<List<String>> getAllVideosThum() async {

}

Future<String> searchUser() async {

}

Future<String> getProfile(String login) async {

}

Future<String>
*/
