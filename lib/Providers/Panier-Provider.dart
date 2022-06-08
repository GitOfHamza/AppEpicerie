import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Consts/firebase_const.dart';
import 'package:flutter_application_1/Models/Panier-Model.dart';
import 'package:flutter_application_1/Services/Alert.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class PanierProvider with ChangeNotifier {
  final Map<String, PanierModel> _cartItems = {};

  Map<String, PanierModel> get getCartItems {
    return _cartItems;
  }

  static Future<void> addProductsToCart(
      {required String productId,
      required int quantity,
      required BuildContext context}) async {
    final User? user = auth.currentUser;
    final _uid = user!.uid;
    final cartId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('clients').doc(_uid).update({
        'panier': FieldValue.arrayUnion([
          {
            'idPanier': cartId,
            // 'idClient': _uid,
            'idProduit': productId,
            'quantite': quantity,
            // 'dateCommande': Timestamp.now(),
          }
        ])
      });
      await Fluttertoast.showToast(
        msg: "L'article a été ajouté à votre panier",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (erreur) {
      AlertMessage.messageError(subTitle: '$erreur', context: context);
    }
  }

  final userCollection = FirebaseFirestore.instance.collection('clients');
  Future<void> fetchCart() async {
    final User? user = auth.currentUser;
    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
    if (userDoc == null) {
      return;
    }
    final leng = userDoc.get('panier').length;
    for (int i = 0; i < leng; i++) {
      _cartItems.putIfAbsent(
          userDoc.get('panier')[i]['idProduit'],
          () => PanierModel(
                id: userDoc.get('panier')[i]['idPanier'],
                productId: userDoc.get('panier')[i]['idProduit'],
                quantity: userDoc.get('panier')[i]['quantite'],
              ));
    }
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

  Future<void> removeItem(
      {required String cartId,
      required String productId,
      required int quantity}) async {
    final User? user = auth.currentUser;
    await userCollection.doc(user!.uid).update({
      'panier': FieldValue.arrayRemove([
        {'idPanier': cartId, 'idProduit': productId, 'quantite': quantity}
      ])
    });
    _cartItems.remove(productId);
    await fetchCart();
    notifyListeners();
  }

  Future<void> clearOnLigneCart() async {
      final User? user = auth.currentUser;
      await userCollection.doc(user!.uid).update({
        'panier': [],
      });
      clearCart();
      notifyListeners();
    }
  
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

}
