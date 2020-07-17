import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:swell_mobile_ui/eth_utils/keys.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'dart:convert';

const SECRET_FILE = 'secret.txt';

Future<String> _getDocumentsPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<String> _getTmpDirectory() async {
  final directory = await getTemporaryDirectory();
  return directory.path;
}

Future<File> getSecretFile() async {
  final path = await _getDocumentsPath();
  return File('${path}/${SECRET_FILE}');
}

Future<bool> writeSecretFile(File file, Secret secret) async {
  await file.writeAsString(jsonEncode(secret));
  return true;
}

Future<Secret> readSecretFile(File file) async {
  var contents = await file.readAsString();
  return  Secret.fromJson(jsonDecode(contents));
}

Future<bool> secretExists(File secret) async {
  return await secret.exists();
}