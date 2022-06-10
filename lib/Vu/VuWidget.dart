// import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Models/History_Model.dart';
// import 'package:flutter_application_1/Providers/List_Of_Products.dart';
// import 'package:flutter_application_1/Providers/Panier-Provider.dart';
// import 'package:flutter_application_1/Services/tools.dart';
// import 'package:provider/provider.dart';

// class VuWidget extends StatefulWidget {
//   const VuWidget({Key? key}) : super(key: key);

//   @override
//   State<VuWidget> createState() => _VuWidgetState();
// }

// class _VuWidgetState extends State<VuWidget> {
//   @override
//   Widget build(BuildContext context) {
//     final productProvider = Provider.of<ProductsProvider>(context);

//     final viewedProdModel = Provider.of<ViewedProductModel>(context);

//     final getCurrProduct =
//         productProvider.getProductById(viewedProdModel.productId);
//     double usedPrice = getCurrProduct!.isOnSolde
//         ? getCurrProduct.solde
//         : getCurrProduct.prix;
//     final cartProvider = Provider.of<PanierProvider>(context);
//     bool? _isInCart = cartProvider.getCartItems.containsKey(getCurrProduct.id);
//     Size size = MyTools(context).getScreenSize;
//     Color couleur = MyTools(context).color;
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: GestureDetector(
//         onTap: () {
//           // Navigator.pushNamed(context, '/DetailleOfProduct');
//         },
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             FancyShimmerImage(
//               height: size.width * 0.2,
//               width: size.width * 0.25,
//               imageUrl:
//                   getCurrProduct.imageUrl,
//               boxFit: BoxFit.fill,
//             ),
//             const SizedBox(width: 12,),
//             Column(
//               children: [
//                 Text(
//                   getCurrProduct.title,
//                   style: TextStyle(
//                     color: couleur,
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold
//                   ),
//                 ),
//                 const SizedBox(height: 12,),
//                 Text(
//                   getCurrProduct.productCategoryName,
//                   style: TextStyle(
//                     color: couleur,
//                     fontSize: 20,
//                   ),
//                 ),
//               ],
//             ),
//             const Spacer(),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 5),
//               child: moveToCart(
//                 fct: () {
//                   setState(() {
//                   });
//                 },
//                 icon: CupertinoIcons.plus,
//                 color: Colors.green,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget moveToCart(
//       {required Function fct, required IconData icon, required Color color}) {
//     return Flexible(
//       flex: 2,
//       child: Material(
//         borderRadius: BorderRadius.circular(12),
//         color: color,
//         child: InkWell(
//             borderRadius: BorderRadius.circular(12),
//             onTap: () {
//               fct();
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Icon(
//                 icon,
//                 color: Colors.white,
//                 size: 25,
//               ),
//             )),
//       ),
//     );
//   }
// }

