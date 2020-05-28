import 'dart:io';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:swell_mobile_ui/eth_utils/keys.dart';

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

Future<bool> createSecretFile(File file) async {
  var cred = await generateNewCredentials();
  await file.writeAsString('0x${cred[0]}\n${cred[1]}\n');
  return true;
}

Future<List<String>> readSecretFile(File file) async {
  var contents = await file.readAsString();
  var priv = contents.split('\n')[0];
  var address = contents.split('\n')[1].substring(2);
  return [priv, address];
}

Future<bool> secretExists(File secret) async {
  return await secret.exists();
}