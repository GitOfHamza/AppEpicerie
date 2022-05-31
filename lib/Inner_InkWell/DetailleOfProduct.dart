import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Models/Product.dart';
import 'package:flutter_application_1/Providers/List_Of_Products.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_application_1/Widgets/BackLastPage.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class DetailleOfProduct extends StatefulWidget {
  const DetailleOfProduct({Key? key}) : super(key: key);

  @override
  State<DetailleOfProduct> createState() => _DetailleOfProductState();
}

class _DetailleOfProductState extends State<DetailleOfProduct> {
  final quantiteController = TextEditingController(text: '1');

  @override
  void dispose() {
    quantiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color couleur = MyTools(context).color;
    Size size = MyTools(context).getScreenSize;
    // final productProvider = Provider.of<ProductsProvider>(context);
    // final idProduit = ModalRoute.of(context)!.settings.arguments as String;
    // final getCurrentProduct = productProvider.getProductById(idProduit);

    // double usedPrice = getCurrProduct.isOnSale
    //     ? getCurrProduct.salePrice
    //     : getCurrProduct.price;
    // double totalPrice = usedPrice * int.parse(_quantityTextController.text);
    // bool? _isInCart = cartProvider.getCartItems.containsKey(getCurrProduct.id);
    return Scaffold(
      appBar: AppBar(
          leading: const BackLastPage(),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: Column(children: [
        Flexible(
          flex: 2,
          child: FancyShimmerImage(
            imageUrl:
                'http://assets.stickpng.com/images/580b57fcd9996e24bc43c12b.png',
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
                        'Title',
                        style: TextStyle(
                            color: couleur,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      )),
                      GestureDetector(
                        onTap: () {},
                        child:
                            Icon(IconlyLight.heart, size: 25, color: couleur),
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
                      const Text(
                        '11 DH',
                        style: TextStyle(
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
                        visible: true,
                        child: Text(
                          '13 Dh',
                          style: TextStyle(
                              fontSize: 17,
                              color: couleur,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(63, 200, 101, 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: const Text(
                          'livraison gratuite',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
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
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  decoration: BoxDecoration(
                    color: Theme.of(context).dividerColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
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
                                    '11 DH/',
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
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(3),
                          child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(5),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Ajouter au panier',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
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
