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

  // List<ProductModel> listProdcutSearch = [];

  @override
  Widget build(BuildContext context) {
    bool __isEmpty = false;
    Size __size = MyTools(context).getScreenSize;
    final Color couleur = MyTools(context).color;
    final productsProvider = Provider.of<ProductsProvider>(context);
    List<ProductModel> listOfProduct = productsProvider.getProduct;
    // if (listOfProduct.isEmpty) {
    //   print(
    //       "la liste est vide ---------------------------------------------------------------");
    //   productsProvider.fetchProducts();
    //   listOfProduct = productsProvider.getProduct;
    // }
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

/*********************************************************************************** */
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Models/Product.dart';
// import 'package:flutter_application_1/Providers/List_Of_Products.dart';
// import 'package:flutter_application_1/Services/tools.dart';
// import 'package:flutter_application_1/Widgets/BackLastPage.dart';
// import 'package:flutter_application_1/Widgets/Products.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';

// import 'package:provider/provider.dart';



// class BrowseAll extends StatefulWidget {
//   static const routeName = "/BrowseAllState";
//   const BrowseAll({Key? key}) : super(key: key);

//   @override
//   State<BrowseAll> createState() => _BrowseAllState();
// }

// class _BrowseAllState extends State<BrowseAll> {
//   final TextEditingController? _searchTextController = TextEditingController();
//   final FocusNode _searchTextFocusNode = FocusNode();
//   @override
//   void dispose() {
//     _searchTextController!.dispose();
//     _searchTextFocusNode.dispose();
//     super.dispose();
//   }

  // @override
  // void initState() {
  //   final productProvider =
  //       Provider.of<ProductsProvider>(context, listen: false);
  //   productProvider.fetchProducts();
  //   super.initState();
  // }

  // List<ProductModel> listProdcutSearch = [];
//   @override
//   Widget build(BuildContext context) {
//     final Color color = MyTools(context).color;
//     Size size = MyTools(context).getScreenSize;
//     final productsProvider = Provider.of<ProductsProvider>(context);
//     List<ProductModel> allProducts = productsProvider.getProduct;
//     return Scaffold(
//       appBar: AppBar(
//         leading: const BackLastPage(),
//         elevation: 0,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         centerTitle: true,
//         title: Text(
//           'Tous les Produits',
//           style: TextStyle(color: color, fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SizedBox(
//               height: kBottomNavigationBarHeight,
//               child: TextField(
//                 focusNode: _searchTextFocusNode,
//                 controller: _searchTextController,
//                 onChanged: (valuee) {
//                   setState(() {
//                     // listProdcutSearch = productsProvider.searchQuery(valuee);
//                   });
//                 },
//                 decoration: InputDecoration(
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide:
//                         const BorderSide(color: Colors.greenAccent, width: 1),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide:
//                         const BorderSide(color: Colors.greenAccent, width: 1),
//                   ),
//                   hintText: "What's in your mind",
//                   prefixIcon: const Icon(Icons.search),
//                   suffix: IconButton(
//                     onPressed: () {
//                       _searchTextController!.clear();
//                       _searchTextFocusNode.unfocus();
//                     },
//                     icon: Icon(
//                       Icons.close,
//                       color: _searchTextFocusNode.hasFocus ? Colors.red : color,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           _searchTextController!.text.isNotEmpty && listProdcutSearch.isEmpty
//               ? const Text(
//                   'No products found, please try another keyword')
//               : GridView.count(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   crossAxisCount: 2,
//                   padding: EdgeInsets.zero,
//                   // crossAxisSpacing: 10,
//                   childAspectRatio: size.width / (size.height * 0.61),
//                   children: List.generate(
//                       _searchTextController!.text.isNotEmpty
//                           ? listProdcutSearch.length
//                           : allProducts.length, (index) {
//                     return ChangeNotifierProvider.value(
//                       value: _searchTextController!.text.isNotEmpty
//                           ? listProdcutSearch[index]
//                           : allProducts[index],
//                       child: const Products(),
//                     );
//                   }),
//                 ),
//         ]),
//       ),
//     );
//   }
// }
