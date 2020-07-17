import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'keys_pair.g.dart';

@JsonSerializable(createToJson: true)
class KeysPair {
  final String ethPrivateKey;
  final String ethAddress;
  const KeysPair(this.ethPrivateKey, this.ethAddress);
  factory KeysPair.fromJson(Map<String, dynamic> json) => _$KeysPairFromJson(json);
  Map<String, dynamic> toJson() => _$KeysPairToJson(this);
}
