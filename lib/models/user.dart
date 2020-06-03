class User {
  int id;
  String login;
  String eth_addr;
  String bio;
  int czar;
  List<int> videos;
  List<int> video_bought;
  List<int> liked;
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    eth_addr = json['eth_addr'];
    bio = json['bio'];
    czar = json['czar'];
    videos = json['videos'] != null ? List<int>.from(json['videos']): <int>[];
    video_bought = json['video_bought'] != null ? List<int>.from(json['video_bought']) : <int>[];
    liked = json['liked'] != null ? List<int>.from(json['liked']) : <int>[];

  }
  User.empty();
}