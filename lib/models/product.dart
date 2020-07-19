const SERVER_URL = 'https://api.squarrin.com/';
/*
part 'product.g.dart';

class Product {
  final int id;
  final String owner_id;
  final String description;
  final int price;
  finaString path;
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

 */

class UploadProduct {
  int seller_id;
  String description;
  int price;
  String localPath;
  String media_type;
  String product_type;
  UploadProduct() {
    seller_id = 0;
    description = "";
    price = 0;
    localPath = "";
    media_type = "";
    product_type = "";
  }
}