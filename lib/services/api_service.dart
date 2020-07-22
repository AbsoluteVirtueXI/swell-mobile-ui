import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'dart:convert';
import 'package:swell_mobile_ui/models/user.dart';
import 'package:swell_mobile_ui/models/video.dart';
import 'package:swell_mobile_ui/models/item.dart';
import 'package:swell_mobile_ui/models/product.dart';
import 'package:swell_mobile_ui/models/feed.dart';
import 'package:swell_mobile_ui/models/feedme.dart';
import 'package:swell_mobile_ui/models/thread.dart';

import 'package:dio/dio.dart';

const BASE_URL = 'https://api.squarrin.com';

class ApiService {
  Future<bool> get_isRegistered(String ethAddr) async {
    var response = await http.get('${BASE_URL}/is_registered/${ethAddr}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> register(String username, String ethAddress) async {
    var response = await http.post('${BASE_URL}/register',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'username': username,
          'eth_address': ethAddress,
        }));

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      if (res['code'] == 200) {
        return User.fromJson(jsonDecode(res['data']));
      }
    }
  }

  Future<bool> buy_items(List<Item> items) async {
    return true;
  }

  Future<int> getId(String ethAddr) async {
    var response = await http.get('${BASE_URL}/get_id/${ethAddr}');
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      return int.parse(res['message']);
    } else {
      return 0;
    }
  }

  Future<bool> uploadProduct(UploadProduct product) async {
    print("####################################STARTING UPLOAD########################################@");
    print("${product.seller_id}");
    print("${product.price}");
    print("${product.localPath}");
    print("${product.media_type}");
    print("${product.product_type}");
    var uri = Uri.parse("${BASE_URL}/upload_product");
    var request = http.MultipartRequest('POST', uri)
      ..fields['seller_id'] = product.seller_id.toString()
      ..fields['description'] = product.description
      ..fields['price'] = product.price.toString()
      ..fields['media_type'] = product.media_type
      ..fields['product_type'] = product.product_type
      ..files
          .add(await http.MultipartFile.fromPath('content', product.localPath));
    request.headers.addAll({HttpHeaders.authorizationHeader: "${product.seller_id}"});
    print("################################SENDING UPLOAD REQUEST##########################################");
    var response = await request.send();
    print("###########################SENDING UPLOAD DONE#############################");
    print(response.statusCode);
    print("#########################################STATUS CODE ABOVE######################################");
    /*
    var dio = Dio();
    var formData = FormData.fromMap({
      "owner_id": video.ownerId,
      "title": video.title,
      "bio": video.bio,
      "price": video.price,
      "content": await MultipartFile.fromFile(video.localPath,filename: "upload.mp4"),
    });
    var response = await dio.post("${BASE_URL}/upload_video", data: formData);
     */
    if (response.statusCode == 201) {
      print("UPLOAD DONE OK");
      return true;
    } else {
      print("UPLOAD FAILED");
      return false;
    }
  }

  Future<bool> uploadItem(UploadItem video) async {
    print("STARTING UPLOAD Item");
    var uri = Uri.parse("${BASE_URL}/upload_item");
    var request = http.MultipartRequest('POST', uri)
      ..fields['owner_id'] = video.ownerId.toString()
      ..fields['title'] = video.title
      ..fields['bio'] = video.bio
      ..fields['price'] = video.price.toString()
      ..files
          .add(await http.MultipartFile.fromPath('content', video.localPath));
    var response = await request.send();
    /*
    var dio = Dio();
    var formData = FormData.fromMap({
      "owner_id": video.ownerId,
      "title": video.title,
      "bio": video.bio,
      "price": video.price,
      "content": await MultipartFile.fromFile(video.localPath,filename: "upload.mp4"),
    });
    var response = await dio.post("${BASE_URL}/upload_video", data: formData);

     */
    if (response.statusCode == 201) {
      print("UPLOAD DONE OK");
      return true;
    } else {
      print("UPLOAD FAILED");
      return false;
    }
  }

  Stream<User> profileStream(int id) async* {
    while (true) {
      print('One api call for profile');
      var response = await http.get('${BASE_URL}/get_user_by_id/${id}');
      if (response.statusCode == 200) {
        if (response.statusCode == 200) {
          var res = jsonDecode(response.body);
          if (res['code'] == 200) {
            yield User.fromJson(jsonDecode(res['data']));
          }
        }
      }
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  Stream<List<Video>> allVideoStream() async* {
    while(true) {
      print('One api call for Video Stream');
      var response = await http.get('${BASE_URL}/get_all_videos');
      if(response.statusCode == 200) {
        var videos = (jsonDecode(response.body) as List).map((i) =>
            Video.fromJson(i)).toList();
        yield videos;
      }
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  Stream<List<Item>> allItemStream() async* {
    while(true) {
      print('One api call for Item Stream');
      var response = await http.get('${BASE_URL}/get_all_items');
      if(response.statusCode == 200) {
        var items = (jsonDecode(response.body) as List).map((i) =>
            Item.fromJson(i)).toList();
        yield items;
      }
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  Stream<List<Feed>> allFeedsStream(int token) async* {
    while(true) {
      print('one api call for Feed Stream');
      var response = await http.get('${BASE_URL}/get_products_feed', headers: {'Authorization': '${token}'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        if (res['code'] == 200) {
          var feeds = (jsonDecode(res['data']) as List).map((i) => Feed.fromJson(i)).toList();
          yield feeds;
        }
      }

      await Future.delayed(const Duration(seconds: 5));
    }
  }

  Stream<List<Feedme>> allMyFeedStream(int token) async* {
    while(true) {
      print('one api call for Feed Stream');
      var response = await http.get('${BASE_URL}/get_my_products_feed', headers: {'Authorization': '${token}'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        if (res['code'] == 200) {
          var feeds = (jsonDecode(res['data']) as List).map((i) => Feedme.fromJson(i)).toList();
          yield feeds;
        }
      }
      await Future.delayed(const Duration(seconds: 5));
    }
  }

  Stream<List<Thread>> allThreadStream(int token) async* {
    while(true) {
      print('one api call for thread stream for user ${token}');
      var response = await http.get('${BASE_URL}/get_my_threads', headers: {'Authorization': '${token}'});
      if(response.statusCode == 200) {
        var res = jsonDecode(response.body);
        if(res['code'] == 200) {
          var threads = (jsonDecode(res['data']) as List).map((i) => Thread.fromJson(i)).toList();
          yield threads;
        }
      }
      await Future.delayed(const Duration(seconds: 3));
    }
  }

  //Stream<List<Message>> allMessageStream(int token, int message)

}
