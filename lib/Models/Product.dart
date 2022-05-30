class ProductModel {
  final String id, title, imageUrl, productCategoryName;
  final double prix, solde;
  final bool isOnSolde, isPiece;

  ProductModel(
      {required this.id,
      required this.title,
      required this.imageUrl,
      required this.productCategoryName,
      required this.prix,
      required this.solde,
      required this.isOnSolde,
      required this.isPiece});
}
