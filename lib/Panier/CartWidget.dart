import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Models/Panier-Model.dart';
import 'package:flutter_application_1/Models/Product.dart';
import 'package:flutter_application_1/Providers/List_Of_Products.dart';
import 'package:flutter_application_1/Providers/Panier-Provider.dart';
import 'package:flutter_application_1/Providers/Wishlist_Provider.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key, required this.currentQuantite}) : super(key: key);
  final int currentQuantite;

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final quantiteController = TextEditingController();
  @override
  void initState() {
    quantiteController.text = widget.currentQuantite.toString();
    super.initState();
  }

  @override
  void dispose() {
    quantiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MyTools(context).getScreenSize;
    Color couleur = MyTools(context).color;
    var Quantite;
    bool quantiteChanged = false;

    final productProvider = Provider.of<ProductsProvider>(context);
    final cartModel = Provider.of<PanierModel>(context);
    final cartProvider = Provider.of<PanierProvider>(context);
    final getCurrentProduct =
        productProvider.getProductById(cartModel.productId);
    // final productsModel = Provider.of<ProductModel>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist =
        wishlistProvider.getWishlistItems.containsKey(getCurrentProduct!.id);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          // Navigator.pushNamed(context, '/DetailleOfProduct',
          //     arguments: cartModel.productId);
        },
        child: Row(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.25,
                    height: size.width * 0.25,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: FancyShimmerImage(
                      imageUrl: getCurrentProduct.imageUrl,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getCurrentProduct.title,
                        style: TextStyle(
                            color: couleur,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: size.width * 0.3,
                        child: Row(
                          children: [
                            _quantiteController(
                                onClick: () {
                                  if (quantiteController.text.isEmpty ||
                                      quantiteController.text == '1') {
                                    return;
                                  } else {
                                    cartProvider.decrementationDeLaQuantite(
                                        cartModel.productId);
                                    setState(() {
                                      quantiteController.text =
                                          (int.parse(quantiteController.text) -
                                                  1)
                                              .toString();
                                    });
                                  }
                                },
                                icon: CupertinoIcons.minus,
                                couleur: Colors.red),
                            Flexible(
                                flex: 1,
                                child: TextFormField(
                                  controller: quantiteController,
                                  key: const ValueKey(10),
                                  style:
                                      TextStyle(color: couleur, fontSize: 17),
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  enabled: true,
                                  onChanged: (valeur) {
                                    setState(() {
                                      if (valeur.isEmpty) {
                                        quantiteController.text = '1';
                                      }
                                    });
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9.]'))
                                  ],
                                )),
                            _quantiteController(
                                onClick: () {
                                  cartProvider.incrementationDeLaQuantite(
                                      cartModel.productId);
                                  setState(() {
                                    quantiteController.text =
                                        (int.parse(quantiteController.text) + 1)
                                            .toString();
                                  });
                                },
                                icon: CupertinoIcons.plus,
                                couleur: Colors.green),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            cartProvider.removeItem(getCurrentProduct.id);
                          },
                          child: const Icon(
                            CupertinoIcons.cart_badge_minus,
                            color: Colors.red,
                            size: 25,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
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
                              color: _isInWishlist ? Colors.red : couleur),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          quantiteChanged == true &&
                                  Quantite.toString().isNotEmpty
                              ? '${(getCurrentProduct.prix * double.parse(Quantite)).toStringAsFixed(2)} DH'
                              : '${getCurrentProduct.prix} DH',
                          style: TextStyle(
                            color: couleur,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _quantiteController(
      {required Function onClick,
      required IconData icon,
      required Color couleur}) {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: couleur,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                onClick();
              },
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              )),
        ),
      ),
    );
  }
}
