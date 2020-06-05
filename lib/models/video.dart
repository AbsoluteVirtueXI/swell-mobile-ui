const SERVER_URL = 'http://192.168.0.10:7777/';

class Video {
  int id;
  int owner_id;
  String title;
  String bio;
  int price;
  String path;
  int views;
  int liked;
  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    owner_id = json['owner_id'];
    title = json['title'];
    bio = json['bio'];
    price = json['price'];
    path = SERVER_URL + json['path'];
    views = json['views'];
    liked = json['liked'];
  }
}

class UploadVideo {
  int ownerId;
  String title;
  String bio;
  int price;
  String localPath;
  UploadVideo() {
    ownerId = 0;
    title = "";
    bio = "";
    price = 0;
    localPath = "";
  }
}
