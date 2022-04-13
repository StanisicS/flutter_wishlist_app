class WishlistItemModel {
  late String id;
  late String name;
  String? description;
  String? url;

  WishlistItemModel({
    required this.id,
    required this.name,
    this.description,
    this.url,
  });
  WishlistItemModel.fromJson(Map<String, dynamic> json) {
    id = json["id"].toString();
    name = json["name"].toString();
    description = json["description"].toString();
    url = json["url"].toString();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["url"] = url;
    return data;
  }
}
