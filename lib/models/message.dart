import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable(createToJson: true)
class Message {
  final int id;
  final int sender;
  final int receiver;
  final String content;
  final DateTime created_at;

  const Message(
      {@required this.id,
      @required this.sender,
      @required this.receiver,
      @required this.content,
      @required this.created_at});

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
