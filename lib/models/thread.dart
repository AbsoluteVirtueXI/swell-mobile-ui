import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'thread.g.dart';

@JsonSerializable(createToJson: true)
class Thread {
  final int id;
  final String username;
  final String avatar;
  final String content;
  final DateTime created_at;
  const Thread({
    @required this.id,
    @required this.username,
    @required this.avatar,
    @required this.content,
    @required this.created_at
  });

  factory Thread.fromJson(Map<String, dynamic> json) => _$ThreadFromJson(json);
  Map<String, dynamic> toJson() => _$ThreadToJson(this);

}