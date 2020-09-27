import 'package:flutter/foundation.dart';
import 'package:swell_mobile_ui/models/video.dart';
import 'package:swell_mobile_ui/models/item.dart';
import 'package:swell_mobile_ui/models/feed.dart';

class CartModel extends ChangeNotifier {
  final List<Feed> feeds = [];

  void addItem(Feed feed) {
    for (final elem in feeds) {
      if (feed.id == elem.id) {
        return;
      }
    }
      feeds.add(feed);
      notifyListeners();
  }

  void removeItem(Feed feed) {
    feeds.remove(feed);
    notifyListeners();
  }

  bool hasItem(Feed feed) {
    for (final elem in feeds) {
      if (feed.id == elem.id) {
        return true;
      }
    }
    return false;
  }

}
