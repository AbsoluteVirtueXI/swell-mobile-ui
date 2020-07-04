const SERVER_URL = 'https://api.squarrin.com/';

class Item {
  int id;
  int owner_id;
  String title;
  String bio;
  int price;
  String path;
  int views;
  int liked;
  Item.fromJson(Map<String, dynamic> json) {
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

class UploadItem {
  int ownerId;
  String title;
  String bio;
  int price;
  String localPath;
  UploadItem() {
    ownerId = 0;
    title = "";
    bio = "";
    price = 0;
    localPath = "";
  }
}
