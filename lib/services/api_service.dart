import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:swell_mobile_ui/models/user.dart';

const BASE_URL = 'http://192.168.0.10:7777';


class ApiService {
  Future<bool> get_isRegistered(String ethAddr) async {
    var response = await  http.get('${BASE_URL}/is_registered/${ethAddr}');
    if(response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(String ethAddr, String login) async {
    var response = await http.post(
        '${BASE_URL}/register',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'login' : login,
          'eth_addr' : ethAddr,
        })
    );

    if(response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
  
  Future<int> getId(String ethAddr) async {
    var response = await http.get('${BASE_URL}/get_id/${ethAddr}');
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      return int.parse(res['message']);
    } else {
      return 0;
    }
  }

  Stream<User> profileStream(int id) async* {
    while(true) {
      print('One api call');
      await Future.delayed(const Duration(seconds: 5));
      var response = await http.get('${BASE_URL}/get_user_by_id/${id}');
      if(response.statusCode == 200) {
        var profile = User.fromJson(jsonDecode(response.body));
        yield profile;
      }
  }
  }
  
}