// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    username: json['username'] as String,
    ethAddress: json['ethAddress'] as String,
    bio: json['bio'] as String,
    quadreum: json['quadreum'] as int,
    avatar: json['avatar'] as String,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'ethAddress': instance.ethAddress,
      'bio': instance.bio,
      'quadreum': instance.quadreum,
      'avatar': instance.avatar,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
