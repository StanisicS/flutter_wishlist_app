import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers.dart';
import '../models/wishlist_model.dart';

final sharedPrefsProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final localStorageProvider = Provider<LocalStorage>((ref) {
  final _sharedPrefs = ref.watch(sharedPrefsProvider);
  return LocalStorage(sharedPreferences: _sharedPrefs);
});

class LocalStorage {
  LocalStorage({
    required this.sharedPreferences,
  });

  final SharedPreferences sharedPreferences;

  WishlistModel loadWishlistData() {
    Map<String, dynamic> decodeOptions = jsonDecode(
        sharedPreferences.getString(sharedPrefKey) ?? emptyJsonStringData);
    WishlistModel wishlistItemListModel = WishlistModel.fromJson(decodeOptions);
    return wishlistItemListModel;
  }

  void saveWishlistData(WishlistModel wishlistItemListModel) {
    if (wishlistItemListModel.data.isNotEmpty) {
      Map<String, dynamic> decodeOptions = wishlistItemListModel.toJson();
      String savedData = jsonEncode(
        WishlistModel.fromJson(decodeOptions),
      );
      sharedPreferences.setString(sharedPrefKey, savedData);
    } else {
      sharedPreferences.setString(sharedPrefKey, emptyJsonStringData);
    }
  }
}
