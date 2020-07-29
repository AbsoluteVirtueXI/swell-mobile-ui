import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'profile.g.dart';

@JsonSerializable(createToJson: true)
class Profile {
  final int id;
  final String username;
  final String eth_address;
  final String bio;
  final int quadreum;
  final String avatar;
  final DateTime created_at;

  const Profile({
    @required this.id,
    @required this.username,
    @required this.eth_address,
    @required this.bio,
    @required this.quadreum,
    @required this.avatar,
    @required this.created_at,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}