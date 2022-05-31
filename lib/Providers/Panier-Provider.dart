import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Models/Panier-Model.dart';

class PanierProvider with ChangeNotifier {
  Map<String, PanierModel> _cartItems = {};

  Map<String, PanierModel> get getCartItems {
    return _cartItems;
  }

  void addProductsToCart({
    required String productId,
    required int quantity,
  }) {
    _cartItems.putIfAbsent(
      productId,
      () => PanierModel(
        id: DateTime.now().toString(),
        productId: productId,
        quantity: quantity,
      ),
    );
    notifyListeners();
  }

  void decrementationDeLaQuantite(String productId) {
    _cartItems.update(
      productId,
      (value) => PanierModel(
        id: value.id,
        productId: productId,
        quantity: value.quantity - 1,
      ),
    );

    notifyListeners();
  }

  void incrementationDeLaQuantite(String productId) {
    _cartItems.update(
      productId,
      (value) => PanierModel(
        id: value.id,
        productId: productId,
        quantity: value.quantity + 1,
      ),
    );
    notifyListeners();
  }
  
  void removeItem(String productId) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}