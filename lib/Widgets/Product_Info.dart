import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Product.dart';
import 'package:flutter_application_1/Providers/List_Of_Products.dart';
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
    final productsModel = Provider.of<ProductModel>(context);
    final theme = MyTools(context).getTheme;
    Size size = MyTools(context).getScreenSize;
    Color color = MyTools(context).color;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {
            Navigator.pushNamed(context, '/DetailleOfProduct', arguments: productsModel.id);
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
                                onTap: () {},
                                child: Icon(IconlyLight.bag2,
                                    size: 22, color: color),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Icon(IconlyLight.heart,
                                    size: 22, color: color),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 8,),
                  PriceNameOfProduct(isOnSolde: productsModel.isOnSolde,prix: productsModel.prix,soldePrix: productsModel.solde,),
                  const SizedBox(height: 5),
                  Text(productsModel.title,style: TextStyle(
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
