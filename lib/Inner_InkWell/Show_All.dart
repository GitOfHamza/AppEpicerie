import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Product.dart';
import 'package:flutter_application_1/Providers/List_Of_Products.dart';
import 'package:flutter_application_1/Services/No%20data.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_application_1/Widgets/BackLastPage.dart';
import 'package:flutter_application_1/Widgets/Product_Info.dart';
import 'package:flutter_application_1/Widgets/Products.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class ShowAll extends StatelessWidget {
  const ShowAll({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductsProvider>(context);
    List<ProductModel> productOnSolde = productsProvider.getProductOnSale;
    Size __size = MyTools(context).getScreenSize;
    final Color couleur = MyTools(context).color;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Produits en solde',
          style: TextStyle(color: couleur, fontWeight: FontWeight.bold),
        ),
        leading: const BackLastPage(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: productOnSolde.isEmpty ? const PageIsEmpty(isOnSolde: true,): GridView.count(
          // crossAxisSpacing: 2,
          padding: EdgeInsets.zero,
          crossAxisCount: 2,
          childAspectRatio: __size.width / (__size.height * 0.55),
          children: List.generate(productOnSolde.length, (index) {
            return ChangeNotifierProvider.value(
                    value: productOnSolde[index], child: const ProductInfo());
          })),
    );
  }
}