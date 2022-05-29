import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({Key? key}) : super(key: key);

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  final quantiteController = TextEditingController();
  @override
  void initState() {
    quantiteController.text = '1';
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/DetailleOfProduct');
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
                      imageUrl:
                          'http://assets.stickpng.com/images/580b57fcd9996e24bc43c12b.png',
                      boxFit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Titre',
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
                                  if (quantiteController.text == '1') {
                                    return;
                                  } else {
                                    setState(() {
                                      quantiteController.text = (int.parse(
                                                  quantiteController.text) -
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
                                 setState(() {
                                    quantiteController.text =
                                        (int.parse(quantiteController.text) +
                                                1)
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
                          onTap: () {},
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
                          onTap: () {},
                          child:
                              Icon(IconlyLight.heart, size: 25, color: couleur),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          quantiteChanged == true &&
                                  Quantite.toString().isNotEmpty
                              ? '${(11 * double.parse(Quantite)).toStringAsFixed(2)} DH'
                              : '11 DH',
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
