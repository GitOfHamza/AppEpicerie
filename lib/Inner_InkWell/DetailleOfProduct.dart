import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Consts/firebase_const.dart';
import 'package:flutter_application_1/Models/Product.dart';
import 'package:flutter_application_1/Providers/List_Of_Products.dart';
import 'package:flutter_application_1/Providers/Panier-Provider.dart';
import 'package:flutter_application_1/Providers/Wishlist_Provider.dart';
import 'package:flutter_application_1/Services/Alert.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_application_1/Widgets/BackLastPage.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DetailleOfProduct extends StatefulWidget {
  final String productId;
  const DetailleOfProduct({Key? key, required this.productId})
      : super(key: key);

  @override
  State<DetailleOfProduct> createState() =>
      _DetailleOfProductState(this.productId);
}

class _DetailleOfProductState extends State<DetailleOfProduct> {
  final quantiteController = TextEditingController(text: '1');
  final String _productId;
  bool loadingPanier = false;
  bool loadingFav = false;
  _DetailleOfProductState(this._productId);

  @override
  void dispose() {
    quantiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color couleur = MyTools(context).color;
    Size size = MyTools(context).getScreenSize;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<PanierProvider>(context);
    final getCurrentProduct = productProvider.getProductById(_productId);

    double usedPrice = getCurrentProduct!.isOnSolde
        ? getCurrentProduct.solde
        : getCurrentProduct.prix;
    double totalPrice = usedPrice * int.parse(quantiteController.text);
    bool? _isInCart =
        cartProvider.getCartItems.containsKey(getCurrentProduct.id);
    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrentProduct.id);
    return Scaffold(
      appBar: AppBar(
          leading: const BackLastPage(),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: Column(children: [
        Flexible(
          flex: 2,
          child: FancyShimmerImage(
            imageUrl: getCurrentProduct.imageUrl,
            boxFit: BoxFit.scaleDown,
            width: size.width,
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withOpacity(1.0),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                        getCurrentProduct.title,
                        style: TextStyle(
                            color: couleur,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )),
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
                              await WishlistProvider.addProductToWishlist(
                                  context: context,
                                  productId: getCurrentProduct.id);
                              await cartProvider.fetchCart();
                            } else {
                              await wishlistProvider.removeItem(
                                  wishlistId: wishlistProvider
                                      .getWishlistItems[getCurrentProduct.id]!.id,
                                  productId: getCurrentProduct.id);
                            }
                            await wishlistProvider.fetchWishlist();
                          } catch (error) {
                            AlertMessage.messageError(
                                subTitle: error.toString(), context: context);
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
                                _isInWishlist && user != null
                                    ? IconlyBold.heart
                                    : IconlyLight.heart,
                                size: 22,
                                color: _isInWishlist && user != null
                                    ? Colors.red
                                    : couleur),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '$usedPrice DH',
                        style: const TextStyle(
                            color: Colors.green,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '/Kg',
                        style: TextStyle(
                          color: couleur,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: getCurrentProduct.isOnSolde,
                        child: Text(
                          '${getCurrentProduct.prix} Dh',
                          style: TextStyle(
                              fontSize: 17,
                              color: couleur,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    quantityControl(
                      fct: () {
                        if (quantiteController.text == '1') {
                          return;
                        } else {
                          setState(() {
                            quantiteController.text =
                                (int.parse(quantiteController.text) - 1)
                                    .toString();
                          });
                        }
                      },
                      icon: CupertinoIcons.minus,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      flex: 1,
                      child: TextField(
                        controller: quantiteController,
                        key: const ValueKey('quantity'),
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.green,
                        enabled: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        onChanged: (value) {},
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    quantityControl(
                      fct: () {
                        setState(() {
                          quantiteController.text =
                              (int.parse(quantiteController.text) + 1)
                                  .toString();
                        });
                      },
                      icon: CupertinoIcons.plus,
                      color: Colors.green,
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Center(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).backgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: const Text(
                          'livraison gratuite',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(
                //   height: 8,
                // ),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                  color: couleur,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            FittedBox(
                              child: Row(
                                children: [
                                  Text(
                                    '$totalPrice DH/',
                                    style: TextStyle(
                                        color: couleur,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${quantiteController.text}Kg',
                                    style: TextStyle(
                                      color: couleur,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        child: Material(
                          color: _isInCart ? Colors.blue.shade700 :Colors.green,
                          borderRadius: BorderRadius.circular(3),
                          child: InkWell(
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
                                    await PanierProvider.addProductsToCart(
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
                              borderRadius: BorderRadius.circular(5),
                              child:  Padding(
                                padding:const EdgeInsets.all(10.0),
                                child: loadingPanier == true
                                    ? const Padding(
                                        padding:  EdgeInsets.all(8.0),
                                        child: SizedBox(
                                            height: 15,
                                            width: 15,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            )),
                                      )
                                    : Text(
                                        _isInCart
                                            ? 'Déjà au Panier'
                                            : 'Ajouter au Panier',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 17),
                                        maxLines: 1),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget quantityControl(
      {required Function fct, required IconData icon, required Color color}) {
    return Flexible(
      flex: 2,
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: color,
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
            )),
      ),
    );
  }
}
