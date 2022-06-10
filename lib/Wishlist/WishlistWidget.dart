import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Consts/firebase_const.dart';
import 'package:flutter_application_1/Inner_InkWell/DetailleOfProduct.dart';
import 'package:flutter_application_1/Models/Wishlist_Model.dart';
import 'package:flutter_application_1/Providers/List_Of_Products.dart';
import 'package:flutter_application_1/Providers/Panier-Provider.dart';
import 'package:flutter_application_1/Providers/Wishlist_Provider.dart';
import 'package:flutter_application_1/Services/Alert.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class WishlistWidget extends StatefulWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  State<WishlistWidget> createState() => _WishlistWidgetState();
}

class _WishlistWidgetState extends State<WishlistWidget> {
  bool loadingPanier = false;
  
  @override
  bool loadingFav = false;
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
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    DetailleOfProduct(productId: getCurrentProduct.id),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  animation =
                      CurvedAnimation(parent: animation, curve: Curves.ease);
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
            );
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
                                    onTap: () async {
                                      final User? user = auth.currentUser;
                                      if (user == null) {
                                        AlertMessage.messageError(
                                            subTitle:
                                                'Aucun utilisateur trouvé, veuillez d\'abord vous connecter',
                                            context: context);
                                        return;
                                      }
                                      if (_isInCart) {
                                        await Fluttertoast.showToast(
                                          msg: "L'article est déjà au panier",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                        );
                                        return;
                                      } else {
                                        try {
                                          setState(() {
                                            loadingPanier = true;
                                          });
                                          await PanierProvider
                                              .addProductsToCart(
                                                  context: context,
                                                  productId: getCurrentProduct.id,
                                                  quantity: 1);
                                          await cartProvider.fetchCart();
                                        } catch (error) {
                                          AlertMessage.messageError(
                                              subTitle: error.toString(),
                                              context: context);
                                        } finally {
                                          setState(() {
                                            loadingPanier = false;
                                          });
                                        }
                                      }
                                    },
                                    child: loadingPanier == true
                                        ? Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SizedBox(
                                                height: 15,
                                                width: 15,
                                                child:
                                                    CircularProgressIndicator(
                                                  color: couleur,
                                                  strokeWidth: 2,
                                                )),
                                          )
                                        : Icon(
                                            _isInCart
                                                ? IconlyBold.bag2
                                                : IconlyLight.bag2,
                                            size: 22,
                                            color: _isInCart
                                                ? Colors.green
                                                : couleur,
                                          )),
                                const SizedBox(
                                  width: 12,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      loadingFav = true;
                                    });
                                    try {
                                      final User? user = auth.currentUser;

                                      if (user == null) {
                                        AlertMessage.messageError(
                                            subTitle:
                                                'Aucun utilisateur trouvé, veuillez d\'abord vous connecter',
                                            context: context);
                                        return;
                                      }
                                      if (_isInWishlist == false &&
                                          _isInWishlist != null) {
                                        await WishlistProvider
                                            .addProductToWishlist(
                                                context: context,
                                                productId:
                                                    getCurrentProduct.id);
                                        await cartProvider.fetchCart();
                                      } else {
                                        await wishlistProvider.removeItem(
                                            wishlistId: wishlistProvider
                                                .getWishlistItems[
                                                    getCurrentProduct.id]!
                                                .id,
                                            productId: getCurrentProduct.id);
                                      }
                                      await wishlistProvider.fetchWishlist();
                                    } catch (error) {
                                      AlertMessage.messageError(
                                          subTitle: error.toString(),
                                          context: context);
                                    } finally {
                                      setState(() {
                                        loadingFav = false;
                                      });
                                    }
                                  },
                                  child: loadingFav
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SizedBox(
                                              height: 15,
                                              width: 15,
                                              child: CircularProgressIndicator(
                                                color: couleur,
                                                strokeWidth: 2,
                                              )),
                                        )
                                      : Icon(
                                          _isInWishlist
                                              ? IconlyBold.heart
                                              : IconlyLight.heart,
                                          size: 22,
                                          color: _isInWishlist
                                              ? Colors.red
                                              : couleur),
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
