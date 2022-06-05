import 'package:card_swiper/card_swiper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Consts/ImageAutoScrolle.dart';
import 'package:flutter_application_1/Consts/firebase_const.dart';
import 'package:flutter_application_1/Models/Product.dart';
import 'package:flutter_application_1/Providers/Dark_Theme_Provider.dart';
import 'package:flutter_application_1/Providers/List_Of_Products.dart';
import 'package:flutter_application_1/Screens/Categorie.dart';
import 'package:flutter_application_1/Services/Dark_Theme_Preference.dart';
import 'package:flutter_application_1/Services/fetch_Screen.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_application_1/Widgets/Product_Info.dart';
import 'package:flutter_application_1/Widgets/Products.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // void _submitFormOnRegister() async {
  //   try {
  //     print(
  //         '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
  //     final _uuid = const Uuid().v4();
  //     await FirebaseFirestore.instance.collection('produits').doc(_uuid).set({
  //       'id': _uuid,
  //       'title': 'Pomme rouge',
  //       'prix': 13.00,
  //       'solde': 11.50,
  //       'imageUrl': 'https://i.ibb.co/crwwSG2/red-apple.png',
  //       'productCategoryName': 'Fruits',
  //       'isOnSolde': true,
  //       'createdAt': Timestamp.now(),
  //     });
  //   } catch (erreur) {}
  // }

  @override
  Widget build(BuildContext context) {
    Size __size = MyTools(context).getScreenSize;
    final Color couleur = MyTools(context).color;
    final productsProvider = Provider.of<ProductsProvider>(context);
    List<ProductModel> listOfProduct = productsProvider.getProduct;
    List<ProductModel> productOnSolde = productsProvider.getProductOnSale;
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: __size.height * 0.33,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      ImageAutoScrolle.offerImage[index],
                      fit: BoxFit.fill,
                    );
                  },
                  autoplay: true,
                  itemCount: ImageAutoScrolle.offerImage.length,
                  pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                          color: Colors.white, activeColor: Colors.yellow)),
                  // control: SwiperControl(),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/All_Soldes');
                  // _submitFormOnRegister();
                },
                child: const Text('Voir tout',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                    maxLines: 1),
              ),
              SizedBox(
                height: __size.height * 0.24,
                child: productOnSolde.length >= 1
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 4,
                        itemBuilder: (ctx, index) {
                          return ChangeNotifierProvider.value(
                              value: productOnSolde[index],
                              child: const ProductInfo());
                        })
                    : Center(
                        widthFactor: double.infinity,
                        child: Text(
                          'Pas de Produit en Solde pour le moment',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: couleur,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Notre Produits',
                          style: TextStyle(
                              color: couleur,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          maxLines: 1),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/All_Products');
                      },
                      child: const Text('Parcourir tout',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                          maxLines: 1),
                    ),
                  ],
                ),
              ),
              GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // crossAxisSpacing: 2,
                  padding: EdgeInsets.zero,
                  crossAxisCount: 2,
                  childAspectRatio: __size.width / (__size.height * 0.55),
                  children: List.generate(4, (index) {
                    return ChangeNotifierProvider.value(
                        value: listOfProduct[index], child: const Products());
                  })),
            ],
          ),
        ],
      ),
    );
  }
}
/************************************************************************************************************************ */

// import 'package:card_swiper/card_swiper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Consts/ImageAutoScrolle.dart';
// import 'package:flutter_application_1/Models/Product.dart';
// import 'package:flutter_application_1/Providers/List_Of_Products.dart';
// import 'package:flutter_application_1/Services/tools.dart';
// import 'package:flutter_application_1/Widgets/Product_Info.dart';
// import 'package:flutter_application_1/Widgets/Products.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';

// import 'package:provider/provider.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     final MyTools utils = MyTools(context);
//     final themeState = utils.getTheme;
//     final Color color = MyTools(context).color;
//     Size size = utils.getScreenSize;
//     final productProviders = Provider.of<ProductsProvider>(context);
//     List<ProductModel> allProducts = productProviders.getProduct;
//     List<ProductModel> productsOnSale = productProviders.getProductOnSale;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: size.height * 0.33,
//               child: Swiper(
//                 itemBuilder: (BuildContext context, int index) {
//                   return Image.asset(
//                     ImageAutoScrolle.offerImage[index],
//                     fit: BoxFit.fill,
//                   );
//                 },
//                 autoplay: true,
//                 itemCount: ImageAutoScrolle.offerImage.length,
//                 pagination: const SwiperPagination(
//                     alignment: Alignment.bottomCenter,
//                     builder: DotSwiperPaginationBuilder(
//                         color: Colors.white, activeColor: Colors.red)),
//                 // control: const SwiperControl(color: Colors.black),
//               ),
//             ),
//             const SizedBox(
//               height: 6,
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/All_Soldes');
//                 // _submitFormOnRegister();
//               },
//               child: const Text('Voir tout',
//                   style: TextStyle(color: Colors.blue, fontSize: 20),
//                   maxLines: 1),
//             ),
//             const SizedBox(
//               height: 6,
//             ),
//             Row(
//               children: [
//                 Flexible(
//                   child: SizedBox(
//                     height: size.height * 0.24,
//                     child: ListView.builder(
//                         itemCount: productsOnSale.length < 10
//                             ? productsOnSale.length
//                             : 10,
//                         scrollDirection: Axis.horizontal,
//                         itemBuilder: (ctx, index) {
//                           return ChangeNotifierProvider.value(
//                               value: productsOnSale[index],
//                               child: const ProductInfo());
//                         }),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text('Notre Produits',
//                       style: TextStyle(
//                           color: color,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold),
//                       maxLines: 1),
//                   TextButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/All_Products');
//                     },
//                     child: const Text('Parcourir tout',
//                         style: TextStyle(color: Colors.blue, fontSize: 20),
//                         maxLines: 1),
//                   ),
//                 ],
//               ),
//             ),
//             GridView.count(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               crossAxisCount: 2,
//               padding: EdgeInsets.zero,
//               // crossAxisSpacing: 10,
//               childAspectRatio: size.width / (size.height * 0.59),
//               children: List.generate(
//                   allProducts.length < 4
//                       ? allProducts.length // length 3
//                       : 4, (index) {
//                 return ChangeNotifierProvider.value(
//                   value: allProducts[index],
//                   child: const Products(),
//                 );
//               }),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
