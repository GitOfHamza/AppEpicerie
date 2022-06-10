import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Consts/firebase_const.dart';
import 'package:flutter_application_1/Models/order_model.dart';

class OrdersProvider with ChangeNotifier {
  static final List<OrderModel> _orders = [];
  List<OrderModel> get getOrders {
    return _orders;
  }

  Future<void> fetchOrders() async {
    await FirebaseFirestore.instance
        .collection('ligneCommandes')
        .get()
        .then((QuerySnapshot ordersSnapshot) {
      clearOrders();
      ordersSnapshot.docs.forEach((element) {
        _orders.insert(
          0,
          OrderModel(
            orderId: element.get('idLigneCommande'),
            userId: element.get('idClient'),
            productId: element.get('idProduit'),
            userName: element.get('userName'),
            price: element.get('prix').toString(),
            imageUrl: element.get('imageUrl'),
            quantity: element.get('quantite').toString(),
            orderDate: element.get('dateCommande'),
          ),
        );
      });
    });
    notifyListeners();
  }

  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }
}
