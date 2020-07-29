import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'follower.g.dart';

@JsonSerializable(createToJson: true)
class Follower {
  final int id;
  final String username;
  final String eth_address;
  final String bio;
  final int quadreum;
  final String avatar;
  final DateTime created_at;

  const Follower({
    @required this.id,
    @required this.username,
    @required this.eth_address,
    @required this.bio,
    @required this.quadreum,
    @required this.avatar,
    @required this.created_at,
  });

  factory Follower.fromJson(Map<String, dynamic> json) => _$FollowerFromJson(json);

  Map<String, dynamic> toJson() => _$FollowerToJson(this);
}