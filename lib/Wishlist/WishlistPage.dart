import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Consts/firebase_const.dart';
import 'package:flutter_application_1/Panier/CartWidget.dart';
import 'package:flutter_application_1/Providers/Wishlist_Provider.dart';
import 'package:flutter_application_1/Services/Alert.dart';
import 'package:flutter_application_1/Services/EmptyPage.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_application_1/Widgets/BackLastPage.dart';
import 'package:flutter_application_1/Wishlist/WishlistWidget.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color couleur = MyTools(context).color;
    Size size = MyTools(context).getScreenSize;
    bool isEmptyPage = true;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemsList =
        wishlistProvider.getWishlistItems.values.toList().reversed.toList();
    return wishlistItemsList.isEmpty || user == null
        ? EmptyPage(
            imagePath: 'assets/images/ensembleVide.png',
            message: 'Explorez plus et présélectionnez certains articles',
            textButton: 'Ajouter un souhait',
            fonction: () {
              Navigator.pushNamed(context, '/All_Products');
            })
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: const BackLastPage(),
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                'Votre Souhaits (${wishlistItemsList.length})',
                style: TextStyle(color: couleur, fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      AlertMessage.messageDialog(
                          title: 'Voullez vous vidé cette page?',
                          subTitle: '',
                          fonction: () {
                            wishlistProvider.clearOnLigneWishlist();
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                          context: context);
                    },
                    icon: Icon(IconlyBroken.delete, color: couleur))
              ],
            ),
            body: MasonryGridView.count(
              itemCount: wishlistItemsList.length,
              crossAxisCount: 2,
              // mainAxisSpacing: 4,
              // crossAxisSpacing: 4,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                    value: wishlistItemsList[index],
                    child: const WishlistWidget());
              },
            ));
  }
}
