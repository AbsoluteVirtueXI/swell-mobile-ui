import 'package:swell_mobile_ui/file_utils/file_utils.dart';
import 'package:swell_mobile_ui/models/keys_pair.dart';
import 'package:swell_mobile_ui/models/secret.dart';
import 'package:swell_mobile_ui/services/api_service.dart';
import 'package:swell_mobile_ui/eth_utils/keys.dart';

class SecretService {
  Future<bool> writeSecret(Secret secret) async {
    try {
      var file = await getSecretFile();
      await writeSecretFile(file, secret);
      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<IsRegister> hasSecret() async {
    await Future.delayed(const Duration(seconds: 3));
    Secret secret;
    var first =  await isFirstUse();
    if (first == false) {
      var file = await getSecretFile();
      secret = await readSecretFile(file);
    } else {
      secret = null;
    }
    return IsRegister(!first, secret);
  }
}

Future<bool> isFirstUse() async {
  var file = await getSecretFile();
  return !(await secretExists(file));
}
