import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Models/Product.dart';
import 'package:flutter_application_1/Providers/List_Of_Products.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_application_1/Widgets/PriceOfProduct.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
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
    final Color couleur = MyTools(context).color;
    final Size size = MyTools(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);

    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Theme.of(context).cardColor.withOpacity(0.9),
          borderRadius: BorderRadius.circular(18),
          child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () {
                Navigator.pushNamed(context, '/DetailleOfProduct',
                    arguments: productModel.id);
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(children: [
                  FancyShimmerImage(
                    imageUrl: productModel.imageUrl,
                    width: size.width * 0.20,
                    height: size.width * 0.18,
                    boxFit: BoxFit.fill,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 3,
                        child: Text(
                          productModel.title,
                          maxLines: 1,
                          style: TextStyle(
                              color: couleur,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child:
                            Icon(IconlyLight.heart, size: 22, color: couleur),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Flexible(
                          flex: 4,
                          child: PriceNameOfProduct(
                            quantite: quantiteController.text.isEmpty
                                ? '0'
                                : quantiteController.text,
                            isOnSolde: productModel.isOnSolde,
                            prix: productModel.prix,
                            soldePrix: productModel.solde,
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Flexible(
                          flex: 1,
                            child: TextFormField(
                          controller: quantiteController,
                          key: const ValueKey(10),
                          style: TextStyle(color: couleur, fontSize: 17),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          enabled: true,
                          onChanged: (valeur) {
                            setState(() {
                              quantiteController.text;
                            });
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                          ],
                        )),
                        Text(
                          'KG',
                          style: TextStyle(
                              color: couleur, fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      child: Text('Ajouter au Panier',
                          style: TextStyle(color: couleur, fontSize: 17),
                          maxLines: 1),
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).cardColor),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(18.0),
                                          bottomRight:
                                              Radius.circular(18.0))))),
                    ),
                  )
                ]),
              )),
        ));
  }
}
