import 'dart:math';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/crypto.dart';
import 'package:swell_mobile_ui/models/keys_pair.dart';

Future<KeysPair> generateNewCredentials() async {
  var rng = Random.secure();
  var random = EthPrivateKey.createRandom(rng);
  var address = await random.extractAddress();
  return KeysPair(bytesToInt(random.privateKey).toString(), '${address.toString()}');
}