import 'package:swell_mobile_ui/file_utils/file_utils.dart';
import 'package:swell_mobile_ui/models/secret.dart';

class SecretService {
  Future<Secret> loadSecret() async {
    try {
      var file = await getSecretFile();
      if (await _isFirstUse()) {
        await createSecretFile(file);
      }
      var secret = await readSecretFile(file);
      return secret;
    } catch (e) {
      print(e);
      throw e;
    }
  }
}

Future<bool> _isFirstUse() async {
  var file = await getSecretFile();
  return !(await secretExists(file));
}
