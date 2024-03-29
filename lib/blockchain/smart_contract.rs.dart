import 'dart:io';

import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:path/path.dart' show join, dirname;
import 'package:web_socket_channel/io.dart';

const String rpcUrl = 'http://localhost:7545';
const String wsUrl = 'ws://localhost:7545';

const String privateKey =
    '85d2242ae1b7759934d4b0d4f0d62d666cf7d73e21dbd09d73c7de266b72a25a';

final EthereumAddress contractAddr =
EthereumAddress.fromHex('0xf451659CF5688e31a31fC3316efbcC2339A490Fb');
final EthereumAddress receiver =
EthereumAddress.fromHex('0x6c87E1a114C3379BEc929f6356c5263d62542C13');

final File abiFile = File(join(dirname(Platform.script.path), 'abi.json'));


Future<void> main() async {
  // establish a connection to the ethereum rpc node. The socketConnector
  // property allows more efficient event streams over websocket instead of
  // http-polls. However, the socketConnector property is experimental.
  final client = Web3Client(rpcUrl, Client(), socketConnector: () {
    return IOWebSocketChannel.connect(wsUrl).cast<String>();
  });
  final credentials = await client.credentialsFromPrivateKey(privateKey);
  final ownAddress = await credentials.extractAddress();

  // read the contract abi and tell web3dart where it's deployed (contractAddr)
  final abiCode = await abiFile.readAsString();
  final contract =
  DeployedContract(ContractAbi.fromJson(abiCode, 'Squarrin'), contractAddr);

  // extracting some functions and events that we'll need later
  final transferEvent = contract.event('Transfer');
  final balanceFunction = contract.function('getBalance');
  final sendFunction = contract.function('send');

  // listen for the Transfer event when it's emitted by the contract above
  final subscription = client
      .events(FilterOptions.events(contract: contract, event: transferEvent))
      .take(1)
      .listen((event) {
    final decoded = transferEvent.decodeResults(event.topics, event.data);

    final from = decoded[0] as EthereumAddress;
    final to = decoded[1] as EthereumAddress;
    final value = decoded[2] as BigInt;

    print('$from sent $value Squarrin to $to');
  });

  // check our balance in MetaCoins by calling the appropriate function
  final balance = await client.call(
      contract: contract, function: balanceFunction, params: [ownAddress]);
  print('We have ${balance.first} Squarrin');

  // send all our MetaCoins to the other address by calling the sendCoin
  // function
  await client.sendTransaction(
    credentials,
    Transaction.callContract(
      contract: contract,
      function: sendFunction,
      parameters: [receiver, balance.first],
    ),
  );

  await subscription.asFuture();
  await subscription.cancel();

  await client.dispose();
}