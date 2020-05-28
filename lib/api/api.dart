import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const BASE_URL = 'http://192.168.0.10:7777';

Future<User> get_Profile(int id) async {
  var response = await http.get('${BASE_URL}')
}

Future<String> get_isRegistered (String ethereumAddress) async {
  var response = await  http.get('${BASE_URL}/is_registered/${ethereumAddress}');
  if(response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to call isRegistered');
  }
}


Future<bool> register(String eth_addr, String login) async {
  var response = await http.post(
    '${BASE_URL}/register',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, String>{
      'login' : login,
      'eth_addr' : eth_addr,
    })
  );
  if(response.statusCode == 201) {
    return true;
  } else {
    return false;
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
