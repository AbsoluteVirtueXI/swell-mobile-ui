import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<bool> post_register(String ethAddr, String login) async {
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
}