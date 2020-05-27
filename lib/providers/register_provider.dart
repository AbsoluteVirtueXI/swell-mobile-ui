import 'dart:async';
import 'dart:convert';
import 'package:swell_mobile_ui/api/api.dart';



Future<bool> isRegistered(String ethereumAddress) async {
  Map<String, dynamic> obj;
  try {
    obj = jsonDecode(await get_isRegistered(ethereumAddress));
  }catch(e) {
    print(e);
  }
  return obj['isRegistered'];

}

Future<bool> register(String ethereumAddress) async {

}