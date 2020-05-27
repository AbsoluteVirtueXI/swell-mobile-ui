import 'package:swell_mobile_ui/file_utils/file_utils.dart';
import 'package:swell_mobile_ui/models/secret.dart';


class SecretProvider {
  Secret secret;
  Future<Secret> loadSecret() async {
    String priv;
    String addr;
    bool isFirstUse = false;
    try {
      var file = await getSecretFile();
      if(await _isFirstUse()) {
        isFirstUse = true;
        await createSecretFile(file);
      }
      var contents = await readSecretFile(file);
      priv = contents[0];
      addr = contents[1];
    }catch(e) {
      print(e);
    }
    secret =  Secret(priv, addr, isFirstUse);
    return secret;
  }
}


Future<bool> _isFirstUse() async {
  var file = await getSecretFile();
  return !(await secretExists(file));
}