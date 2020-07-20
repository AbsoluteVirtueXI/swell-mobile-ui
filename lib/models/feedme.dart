import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'feedme.g.dart';

@JsonSerializable(createToJson: true)
class Feedme {
  final int id;
  final int seller_id;
  final String username;
  final String avatar;
  final String product_type;
  final String description;
  final int price;
  final int views;
  final int likes;
  final String path;
  final String thumbnail_path;
  final String media_type;
  final DateTime created_at;
  const Feedme ({
    @required this.id,
    @required this.seller_id,
    @required this.username,
    @required this.avatar,
    @required this.product_type,
    @required this.description,
    @required this.price,
    @required this.views,
    @required this.likes,
    @required this.path,
    @required this.thumbnail_path,
    @required this.media_type,
    @required this.created_at
  });

  factory Feedme.fromJson(Map<String, dynamic> json) => _$FeedmeFromJson(json);
  Map<String, dynamic> toJson() => _$FeedmeToJson(this);
}