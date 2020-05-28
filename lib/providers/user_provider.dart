import 'package:swell_mobile_ui/models/user.dart';

/*
class UserProvider {
  User user;
  Stream<User>
}

 */

class ProfileProvider {
  User user;
  Stream<User> profileStream() {
    Duration interval = Duration(seconds: 2);
    return Stream<User>.periodic(interval, () async => await )
  }
}