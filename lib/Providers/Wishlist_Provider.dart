import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Consts/firebase_const.dart';
import 'package:flutter_application_1/Models/Wishlist_Model.dart';
import 'package:flutter_application_1/Services/Alert.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class WishlistProvider with ChangeNotifier {
  Map<String, WishlistModel> _wishlistItems = {};

  Map<String, WishlistModel> get getWishlistItems {
    return _wishlistItems;
  }

  static Future<void> addProductToWishlist(
      {required String productId, required BuildContext context}) async {
    final User? user = auth.currentUser;
    final _uid = user!.uid;
    final wishlistId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('clients').doc(_uid).update({
        'favorites': FieldValue.arrayUnion([
          {
            'idFavorite': wishlistId,
            'idProduit': productId,
            // 'dateAjout': Timestamp.now(),
          }
        ])
      });
      await Fluttertoast.showToast(
        msg: "L'article a été ajouté à votre liste des favories",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } catch (erreur) {
      AlertMessage.messageError(subTitle: '$erreur', context: context);
    }
  }

  final userCollection = FirebaseFirestore.instance.collection('clients');
  Future<void> fetchWishlist() async {
    final User? user = auth.currentUser;
    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();
    if (userDoc == null) {
      return;
    }
    final leng = userDoc.get('favorites').length;
    for (int i = 0; i < leng; i++) {
      _wishlistItems.putIfAbsent(
          userDoc.get('favorites')[i]['idProduit'],
          () => WishlistModel(
                id: userDoc.get('favorites')[i]['idFavorite'],
                productId: userDoc.get('favorites')[i]['idProduit'],
              ));
    }
    notifyListeners();
  }

  Future<void> removeItem({
    required String wishlistId,
    required String productId,
  }) async {
    final User? user = auth.currentUser;
    await userCollection.doc(user!.uid).update({
      'favorites': FieldValue.arrayRemove([
        {
          'idFavorite': wishlistId,
          'idProduit': productId,
        }
      ])
    });
    _wishlistItems.remove(productId);
    await fetchWishlist();
    notifyListeners();
  }

  Future<void> clearOnLigneWishlist() async {
    final User? user = auth.currentUser;
    await userCollection.doc(user!.uid).update({
      'favorites': [],
    });
    clearWishlist();
    notifyListeners();
  }

  // void removeItem(String productId) {
  //   _wishlistItems.remove(productId);
  //   notifyListeners();
  // }

  void clearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
