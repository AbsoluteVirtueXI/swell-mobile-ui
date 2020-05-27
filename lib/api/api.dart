import 'dart:async';
import 'package:http/http.dart' as http;

const BASE_URL = 'http://192.168.0.10:7777';

Future<String> get_isRegistered (String ethereumAddress) async {
  var response = await  http.get('${BASE_URL}/isRegistered?user=${}');
  if(response.statusCode == 200) {
    return response.body;
  } else {
    throw Exception('Failed to call isRegistered');
  }
}

/*
Future<String> register() async {

}

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
