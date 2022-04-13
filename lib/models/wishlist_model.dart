import 'wishlist_item_model.dart';

class WishlistModel {
  late List<WishlistItemModel> data;

  WishlistModel({
    required this.data,
  });

  WishlistModel.fromJson(Map<String, dynamic> json) {
    if (json["data"] != null) {
      final _data = json["data"];
      final items = <WishlistItemModel>[];
      _data.forEach((item) {
        items.add(WishlistItemModel.fromJson(item));
      });
      data = items;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    final _data = this.data;
    final items = [];
    for (var item in _data) {
      items.add(item.toJson());
      data["data"] = items;
    }
    return data;
  }
}
