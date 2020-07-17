import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(createToJson: true)
class User {
  final int id;
  final String username;
  final String ethAddress;
  final String bio;
  final int quadreum;
  final String avatar;
  final DateTime createdAt;

  const User({
    @required this.id,
    @required this.username,
    @required this.ethAddress,
    @required this.bio,
    @required this.quadreum,
    @required this.avatar,
    @required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

class MyProfile extends User {
  MyProfile();
}

/*
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(createToJson: true)
class User {
  final int id;
  final String username;
  final String ethAddress;
  final String bio;
  final int quadreum;
  final String avatar;
  final int nbFollowers;
  final int nbFollowees;
  final DateTime createdAt;

  const User({
    @required this.id,
    @required this.username,
    @required this.ethAddress,
    @required this.bio,
    @required this.quadreum,
    @required this.avatar,
    @required this.nbFollowees,
    @required this.nbFollowers,
    @required this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
 */

/*
return MaterialApp(
      title: 'Squarrin',
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'Offside',
        primarySwatch: Colors.blue,
        primaryColor: Colors.white,
        //backgroundColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
 */