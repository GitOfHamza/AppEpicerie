import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Wishlist_Model.dart';
import 'package:flutter_application_1/Providers/List_Of_Products.dart';
import 'package:flutter_application_1/Providers/Panier-Provider.dart';
import 'package:flutter_application_1/Providers/Wishlist_Provider.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color couleur = MyTools(context).color;
    Size size = MyTools(context).getScreenSize;
    final productProvider = Provider.of<ProductsProvider>(context);
    final wishlistModel = Provider.of<WishlistModel>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final getCurrentProduct =
        productProvider.getProductById(wishlistModel.productId);
    final cartProvider = Provider.of<PanierProvider>(context);
    bool? _isInCart =
        cartProvider.getCartItems.containsKey(getCurrentProduct!.id);
    double usedPrice = getCurrentProduct.isOnSolde
        ? getCurrentProduct.solde
        : getCurrentProduct.prix;
    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrentProduct.id);
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
          onTap: () {
            // Navigator.pushNamed(context, '/DetailleOfProduct');
          },
          child: Container(
              height: size.height * 0.2,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(1.0),
                  border: Border.all(color: couleur, width: 0.5),
                  borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    width: size.width * 0.2,
                    height: size.width * 0.25,
                    child: FancyShimmerImage(
                      imageUrl: getCurrentProduct.imageUrl,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                  Flexible(
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              children: [
                                const Spacer(),
                                GestureDetector(
                                    onTap: () {
                                      cartProvider.addProductsToCart(
                                          productId: getCurrentProduct.id,
                                          quantity: 1);
                                    },
                                    child: Icon(
                                      _isInCart
                                          ? IconlyBold.bag2
                                          : IconlyLight.bag2,
                                      size: 22,
                                      color: _isInCart ? Colors.green : couleur,
                                    )),
                                const SizedBox(
                                  width: 12,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    wishlistProvider.addRemoveProductToWishlist(
                                        productId: getCurrentProduct.id);
                                  },
                                  child: Icon(
                                      _isInWishlist
                                          ? IconlyBold.heart
                                          : IconlyLight.heart,
                                      size: 22,
                                      color:
                                          _isInWishlist ? Colors.red : couleur),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          flex: 4,
                          child: Text(
                            getCurrentProduct.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: couleur, fontSize: 20),
                            maxLines: 3,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Flexible(
                          child: Text(
                            getCurrentProduct.prix.toString() + ' DH',
                            style: TextStyle(color: couleur, fontSize: 20),
                            maxLines: 1,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
