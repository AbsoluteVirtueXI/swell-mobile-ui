// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keys_pair.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeysPair _$KeysPairFromJson(Map<String, dynamic> json) {
  return KeysPair(
    json['ethPrivateKey'] as String,
    json['ethAddress'] as String,
  );
}

Map<String, dynamic> _$KeysPairToJson(KeysPair instance) => <String, dynamic>{
      'ethPrivateKey': instance.ethPrivateKey,
      'ethAddress': instance.ethAddress,
    };
