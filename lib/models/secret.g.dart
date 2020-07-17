// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secret.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Secret _$SecretFromJson(Map<String, dynamic> json) {
  return Secret(
    json['id'] as int,
    json['ethPrivateKey'] as String,
    json['ethAddress'] as String,
  );
}

Map<String, dynamic> _$SecretToJson(Secret instance) => <String, dynamic>{
      'id': instance.id,
      'ethPrivateKey': instance.ethPrivateKey,
      'ethAddress': instance.ethAddress,
    };
