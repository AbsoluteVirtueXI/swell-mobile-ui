// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follower.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Follower _$FollowerFromJson(Map<String, dynamic> json) {
  return Follower(
    id: json['id'] as int,
    username: json['username'] as String,
    eth_address: json['eth_address'] as String,
    bio: json['bio'] as String,
    quadreum: json['quadreum'] as int,
    avatar: json['avatar'] as String,
    created_at: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  );
}

Map<String, dynamic> _$FollowerToJson(Follower instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'eth_address': instance.eth_address,
      'bio': instance.bio,
      'quadreum': instance.quadreum,
      'avatar': instance.avatar,
      'created_at': instance.created_at?.toIso8601String(),
    };
