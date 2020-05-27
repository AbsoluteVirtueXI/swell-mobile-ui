import 'dart:math';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/crypto.dart';

Future<List<String>> generateNewCredentials() async {
  var rng = Random.secure();
  var random = EthPrivateKey.createRandom(rng);
  var address = await random.extractAddress();
  return [bytesToInt(random.privateKey).toString(), address.toString()];
}