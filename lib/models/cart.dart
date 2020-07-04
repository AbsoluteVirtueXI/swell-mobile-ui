import 'package:flutter/foundation.dart';
import 'package:swell_mobile_ui/models/video.dart';
import 'package:swell_mobile_ui/models/item.dart';

class CartModel extends ChangeNotifier {
  final List<Video> videos = [];
  final List<Item> items = [];

  void addItem(Item item) {
    for (final elem in items) {
      if (item.id == elem.id) {
        return;
      }
    }
      items.add(item);
      notifyListeners();
  }

  void removeItem(Item item) {
    items.remove(item);
    notifyListeners();
  }

  void addVideo(Video video) {
    videos.add(video);
    notifyListeners();
  }

  void removeVideo(Video video) {
    videos.remove(video);
    notifyListeners();
  }
}
