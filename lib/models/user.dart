class User {
  int id;
  String login;
  String eth_addr;
  String bio;
  int czar;
  List<int> videos;
  List<int> video_bought;
  int liked;
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    eth_addr = json['eth_addr'];
    bio = json['bio'];
    czar = json['czar'];
    videos = json['videos'];
    video_bought = json['video_bought'];
    liked = json['liked'];

  }
}

