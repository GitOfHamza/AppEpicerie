import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Consts/firebase_const.dart';
import 'package:flutter_application_1/Models/Product.dart';
import 'package:flutter_application_1/Providers/List_Of_Products.dart';
import 'package:flutter_application_1/Providers/Panier-Provider.dart';
import 'package:flutter_application_1/Providers/Wishlist_Provider.dart';
import 'package:flutter_application_1/Services/Alert.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_application_1/Widgets/PriceOfProduct.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({Key? key}) : super(key: key);

  @override
  State<ProductInfo> createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final productsModel = Provider.of<ProductModel>(context);
    final theme = MyTools(context).getTheme;
    Size size = MyTools(context).getScreenSize;
    Color color = MyTools(context).color;
    final cartProvider = Provider.of<PanierProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productsModel.id);
    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(productsModel.id);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            // Navigator.pushNamed(context, '/DetailleOfProduct',
            //     arguments: productsModel.id);
          },
          child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FancyShimmerImage(
                        imageUrl: productsModel.imageUrl,
                        width: size.width * 0.22,
                        height: size.width * 0.20,
                        boxFit: BoxFit.fill,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            '1KG',
                            style: TextStyle(
                                color: color,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  final User? user = auth.currentUser;
                                  if (user == null) {
                                    AlertMessage.messageError(
                                        subTitle: 'Veuillez s\'authentifier!',
                                        context: context);
                                    return;
                                  }
                                  print(
                                      'UUUUUUUUUUUUUUUUUUUU bag2: ${user.email}');
                                  cartProvider.addProductsToCart(
                                      productId: productsModel.id, quantity: 1);
                                },
                                child: Icon(
                                    _isInCart
                                        ? IconlyBold.bag2
                                        : IconlyLight.bag2,
                                    size: 22,
                                    color: _isInCart ? Colors.green : color),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  final User? user = auth.currentUser;
                                  if (user == null) {
                                    AlertMessage.messageError(
                                        subTitle: 'Veuillez s\'authentifier!',
                                        context: context);
                                    return;
                                  }
                                  wishlistProvider.addRemoveProductToWishlist(
                                      productId: productsModel.id);
                                },
                                child: Icon(
                                    _isInWishlist
                                        ? IconlyBold.heart
                                        : IconlyLight.heart,
                                    size: 22,
                                    color: _isInWishlist ? Colors.red : color),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  PriceNameOfProduct(
                    isOnSolde: productsModel.isOnSolde,
                    prix: productsModel.prix,
                    soldePrix: productsModel.solde,
                  ),
                  const SizedBox(height: 5),
                  Text(productsModel.title,
                      style: TextStyle(
                          color: color,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))
                ],
              )),
        ),
      ),
    );
  }
}
