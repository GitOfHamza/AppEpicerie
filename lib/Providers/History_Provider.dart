import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Models/History_Model.dart';

class ViewedProductProvider with ChangeNotifier {
  Map<String, ViewedProductModel> _viewedProdlistItems = {};

  Map<String, ViewedProductModel> get getViewedProdlistItems {
    return _viewedProdlistItems;
  }

  void addProductToHistory({required String productId}) {
    _viewedProdlistItems.putIfAbsent(
        productId,
        () => ViewedProductModel(
            id: DateTime.now().toString(), productId: productId));

    notifyListeners();
  }

  void clearHistory() {
    _viewedProdlistItems.clear();
    notifyListeners();
  }
}
