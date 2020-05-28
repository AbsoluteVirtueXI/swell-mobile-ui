import 'package:swell_mobile_ui/models/user.dart';
import 'package:swell_mobile_ui/api/api.dart';

/*
class UserProvider {
  User user;
  Stream<User>
}

 */

class ProfileProvider {
  User user;
  Stream<User> profileStream(String eth) async* {
    while (true) {
      try {
        print('pooling');
        await new Future.delayed(Duration(seconds: 3));
        yield await getUser(eth);
      }catch(e) {
        throw e;
      }
    }
  }
}
