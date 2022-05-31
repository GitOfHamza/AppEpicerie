import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Models/Wishlist_Model.dart';

class WishlistProvider with ChangeNotifier {
  Map<String, WishlistModel> _wishlistItems = {};

  Map<String, WishlistModel> get getWishlistItems {
    return _wishlistItems;
  }

  void addRemoveProductToWishlist({required String productId}) {
    if (_wishlistItems.containsKey(productId)) {
      removeItem(productId);
    } else {
      _wishlistItems.putIfAbsent(
          productId,
          () => WishlistModel(
              id: DateTime.now().toString(), productId: productId));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _wishlistItems.remove(productId);
    notifyListeners();
  }

  void clearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}