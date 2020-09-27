// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boughtme.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoughtMe _$BoughtMeFromJson(Map<String, dynamic> json) {
  return BoughtMe(
    id: json['id'] as int,
    seller_id: json['seller_id'] as int,
    username: json['username'] as String,
    avatar: json['avatar'] as String,
    product_type: json['product_type'] as String,
    description: json['description'] as String,
    price: json['price'] as int,
    views: json['views'] as int,
    likes: json['likes'] as int,
    path: json['path'] as String,
    thumbnail_path: json['thumbnail_path'] as String,
    media_type: json['media_type'] as String,
    created_at: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
  );
}

Map<String, dynamic> _$BoughtMeToJson(BoughtMe instance) => <String, dynamic>{
      'id': instance.id,
      'seller_id': instance.seller_id,
      'username': instance.username,
      'avatar': instance.avatar,
      'product_type': instance.product_type,
      'description': instance.description,
      'price': instance.price,
      'views': instance.views,
      'likes': instance.likes,
      'path': instance.path,
      'thumbnail_path': instance.thumbnail_path,
      'media_type': instance.media_type,
      'created_at': instance.created_at?.toIso8601String(),
    };
