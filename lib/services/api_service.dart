import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:swell_mobile_ui/models/user.dart';
import 'package:swell_mobile_ui/models/video.dart';

import 'package:dio/dio.dart';

const BASE_URL = 'http://192.168.0.10:7777';

class ApiService {
  Future<bool> get_isRegistered(String ethAddr) async {
    var response = await http.get('${BASE_URL}/is_registered/${ethAddr}');
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(String ethAddr, String login) async {
    var response = await http.post('${BASE_URL}/register',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{
          'login': login,
          'eth_addr': ethAddr,
        }));

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
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

  Future<bool> uploadVideo(UploadVideo video) async {
    print("STARTING UPLOAD");
    var uri = Uri.parse("${BASE_URL}/upload_video");
    var request = http.MultipartRequest('POST', uri)
      ..fields['owner_id'] = video.ownerId.toString()
      ..fields['title'] = video.title
      ..fields['bio'] = video.bio
      ..fields['prince'] = video.price.toString()
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
      await Future.delayed(const Duration(seconds: 5));
      var response = await http.get('${BASE_URL}/get_user_by_id/${id}');
      if (response.statusCode == 200) {
        var profile = User.fromJson(jsonDecode(response.body));
        yield profile;
      }
    }
  }

  Stream<List<Video>> allVideoStream() async* {
    while(true) {
      print('One api call for Video Stream');
      await Future.delayed(const Duration(seconds: 5));
      var response = await http.get('${BASE_URL}/get_all_videos');
      if(response.statusCode == 200) {
        var videos = (jsonDecode(response.body) as List).map((i) =>
            Video.fromJson(i)).toList();
        yield videos;
      }

    }
  }
}
