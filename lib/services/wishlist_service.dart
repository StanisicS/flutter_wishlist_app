import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../models/wishlist_model.dart';
import '../models/wishlist_item_model.dart';
import 'local_storage_service.dart';

const _uuid = Uuid();

final itemProvider =
    Provider<WishlistItemModel>((ref) => throw UnimplementedError());

final wishlistProvider = StateNotifierProvider<WishlistService, WishlistModel>(
  (ref) {
    final store = ref.watch(localStorageProvider);
    return WishlistService(WishlistModel(data: []), store);
  },
);

class WishlistService extends StateNotifier<WishlistModel> {
  WishlistService(WishlistModel initialItems, this.localStorage)
      : super(
          initialItems,
        );
  final LocalStorage localStorage;

  void overrideData(WishlistModel wishlist) {
    if (wishlist.data.isNotEmpty) {
      state = wishlist;
    }
  }

  void saveData() {
    localStorage.saveWishlistData(state);
  }

  void loadData() {
    final data = localStorage.loadWishlistData();
    state = data;
  }

  void add(String name) {
    state = WishlistModel(data: [
      ...state.data,
      WishlistItemModel(id: _uuid.v4(), name: name),
    ]);
    saveData();
  }

  void edit({required String id, required String name}) {
    state = WishlistModel(data: [
      for (final item in state.data)
        if (item.id == id)
          WishlistItemModel(
            id: item.id,
            name: name,
          )
        else
          item,
    ]);
    saveData();
  }

  void remove(WishlistItemModel target) {
    state = WishlistModel(
        data: state.data.where((item) => item.id != target.id).toList());

    saveData();
  }

  void removeAll() {
    state = WishlistModel(data: []);

    saveData();
  }
}
