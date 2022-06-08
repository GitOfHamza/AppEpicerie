import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_application_1/Models/Product.dart';

class ProductsProvider with ChangeNotifier {

  static final List<ProductModel> _productsList = [];

  List<ProductModel> get getProduct => _productsList;


// Selection des produits ayant en Solde

  List<ProductModel> get getProductOnSale =>
      _productsList.where((element) => element.isOnSolde).toList();

// Selection des produits courants par leurs ID

  ProductModel? getProductById(String? currentID) {
    return _productsList.firstWhere(
        (element) => element.id.toUpperCase() == currentID!.toUpperCase());
  }

// Selection de tout les produits de la table PRODUITS existante sur Firebase

  Future<void> fetchProducts() async {
    await FirebaseFirestore.instance
        .collection('produits')
        .get()
        .then((QuerySnapshot productSnapshot) {
      _productsList.clear();
      productSnapshot.docs.forEach((element) {
        _productsList.insert(
            0,
            ProductModel(
              id: element.get('id'),
              title: element.get('title'),
              imageUrl: element.get('imageUrl'),
              productCategoryName: element.get('productCategoryName'),
              prix: double.parse(
                element.get('prix'),
              ),
              solde: double.parse(element.get('solde')),
              isOnSolde: element.get('isOnSolde'),
            ));
      });
    });
    notifyListeners();
  }

//  Selection des catégories par leur noms

  List<ProductModel> findByCategory(String categoryName) {
    List<ProductModel> _categoryList = _productsList
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return _categoryList;
  }

// Selection des produits par leur titres

  List<ProductModel> searchQuery(String searchText) {
    List<ProductModel> _searchList = _productsList
        .where(
          (element) => element.title.toLowerCase().contains(
                searchText.toLowerCase(),
              ),
        )
        .toList();
    return _searchList;
  }


}