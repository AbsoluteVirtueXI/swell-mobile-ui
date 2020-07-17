import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'secret.g.dart';

@JsonSerializable(createToJson: true)
class Secret {
  final int id;
  final String ethPrivateKey;
  final String ethAddress;
  const Secret(this.id, this.ethPrivateKey, this.ethAddress);
  factory Secret.fromJson(Map<String, dynamic> json) => _$SecretFromJson(json);
  Map<String, dynamic> toJson() => _$SecretToJson(this);
}

class IsRegister {
  final bool register;
  final Secret secret;
  const IsRegister(this.register, this.secret);
}


