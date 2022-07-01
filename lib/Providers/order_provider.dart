import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Consts/firebase_const.dart';
import 'package:flutter_application_1/Models/order_model.dart';

class OrdersProvider with ChangeNotifier {
  static List<OrderModel> _orders = [];
  List<OrderModel> get getOrders {
    return _orders;
  }

  String idCommande = '';
  String idClient = '';
  Timestamp dateCommande = Timestamp(1, 1);
  String prixTotal = '';

  Future<void> fetchOrders() async {
    

    await FirebaseFirestore.instance
        .collection('Commandes')
        .get()
        .then((QuerySnapshot commandeSnapshot) {
      commandeSnapshot.docs.forEach((element) {
        idClient = element.get('idClient');
        idCommande = element.get('idCommande');
        dateCommande = element.get('dateCommande');
        prixTotal = element.get('prixTotal').toString();
      });
    });

    await FirebaseFirestore.instance
        .collection('ligneCommandes')
        .get()
        .then((QuerySnapshot ordersSnapshot) {
      _orders = [];
      ordersSnapshot.docs.forEach((element) {
        _orders.insert(
          0,
          OrderModel(
            orderId: element.get('idLigneCommande'),
            userId: idClient,
            productId: element.get('idProduit'),
            price: element.get('prix').toString(),
            imageUrl: element.get('imageUrl'),
            quantity: element.get('quantite').toString(),
            orderDate: dateCommande,
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
