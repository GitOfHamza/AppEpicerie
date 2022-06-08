import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Consts/ImageAutoScrolle.dart';
import 'package:flutter_application_1/Models/Product.dart';
import 'package:flutter_application_1/Providers/List_Of_Products.dart';
import 'package:flutter_application_1/Services/No%20data.dart';
import 'package:flutter_application_1/Services/fetch_Screen.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_application_1/Widgets/BackLastPage.dart';
import 'package:flutter_application_1/Widgets/Product_Info.dart';
import 'package:flutter_application_1/Widgets/Products.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class BrowseAll extends StatefulWidget {
  const BrowseAll({Key? key}) : super(key: key);

  @override
  State<BrowseAll> createState() => _BrowseAllState();
}

class _BrowseAllState extends State<BrowseAll> {
  
  final TextEditingController? searchController = TextEditingController();
  final FocusNode searchFocusController = FocusNode();

  List<ProductModel> listProdcutSearch = [];

  @override
  void dispose() {
    searchController!.dispose();
    searchFocusController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final productProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    productProvider.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool __isEmpty = false;
    Size __size = MyTools(context).getScreenSize;
    final Color couleur = MyTools(context).color;
    final productsProvider = Provider.of<ProductsProvider>(context);
    List<ProductModel> listOfProduct = productsProvider.getProduct;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tous les Produits',
          style: TextStyle(color: couleur, fontWeight: FontWeight.bold),
        ),
        leading: const BackLastPage(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: __isEmpty
          ? const PageIsEmpty(
              isOnSolde: false,
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SizedBox(
                      height: kBottomNavigationBarHeight,
                      child: TextField(
                        controller: searchController,
                        focusNode: searchFocusController,
                        onChanged: (valuee) {
                          setState(() {
                            listProdcutSearch =
                                productsProvider.searchQuery(valuee);
                          });
                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                                color: Colors.blue.shade200, width: 2),
                          ),
                          hintText: "A quoi penses-tu ?",
                          prefixIcon: const Icon(Icons.search_outlined),
                          suffixIcon: IconButton(
                              onPressed: () {
                                searchController!.clear();
                                searchFocusController.unfocus();
                              },
                              icon: Icon(
                                Icons.close_outlined,
                                color: searchFocusController.hasFocus
                                    ? Colors.red
                                    : couleur,
                              )),
                        ),
                      ),
                    ),
                  ),
                  searchController!.text.isNotEmpty && listProdcutSearch.isEmpty
                      ? const Center(
                          child: Text(
                              'Aucun produit trouvé, veuillez essayer un autre mot-clé'),
                        )
                      : GridView.count(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          // crossAxisSpacing: 2,
                          padding: EdgeInsets.zero,
                          crossAxisCount: 2,
                          childAspectRatio:
                              __size.width / (__size.height * 0.55),
                          children: List.generate(
                              searchController!.text.isNotEmpty
                                  ? listProdcutSearch.length
                                  : listOfProduct.length, (index) {
                            return ChangeNotifierProvider.value(
                                value: searchController!.text.isNotEmpty
                                    ? listProdcutSearch[index]
                                    : listOfProduct[index],
                                child: const Products());
                          })),
                ],
              ),
            ),
    );
  }
}