import 'package:flutter/cupertino.dart';

class ProductModel with ChangeNotifier{
  final String id, title, imageUrl, productCategoryName;
  final double prix, solde;
  final bool isOnSolde;

  ProductModel(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.productCategoryName,
      required this.prix,
      required this.solde,
      required this.isOnSolde});
}
