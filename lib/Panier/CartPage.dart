import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Consts/firebase_const.dart';
import 'package:flutter_application_1/Panier/CartWidget.dart';
import 'package:flutter_application_1/Providers/List_Of_Products.dart';
import 'package:flutter_application_1/Providers/Panier-Provider.dart';
import 'package:flutter_application_1/Providers/order_provider.dart';
import 'package:flutter_application_1/Services/Alert.dart';
import 'package:flutter_application_1/Services/EmptyPage.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  static int newId = 0;

  @override
  Widget build(BuildContext context) {
    Color couleur = MyTools(context).color;
    Size size = MyTools(context).getScreenSize;
    final cartProvider = Provider.of<PanierProvider>(context);
    final cartItemsList =
        cartProvider.getCartItems.values.toList().reversed.toList();

    final productProvider = Provider.of<ProductsProvider>(context);
    final ordersProvider = Provider.of<OrdersProvider>(context);
    double total = 0.0;
    cartProvider.getCartItems.forEach((key, value) {
      final getCurrentProduct = productProvider.getProductById(value.productId);
      total += (getCurrentProduct!.isOnSolde
              ? getCurrentProduct.solde
              : getCurrentProduct.prix) *
          value.quantity;
    });

    return cartItemsList.isEmpty || user == null
        ? EmptyPage(
            imagePath: 'assets/images/ensembleVide.png',
            message: 'Pas encore d\'articles dans votre panier',
            textButton: 'Achetez maintenant',
            fonction: () {
              Navigator.pushNamed(context, '/All_Products');
            })
        : Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: Text(
                'Panier (${cartItemsList.length})',
                style: TextStyle(color: couleur, fontWeight: FontWeight.bold),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      AlertMessage.messageDialog(
                          title: 'Voullez vous vidé le panier?',
                          subTitle: '',
                          fonction: () {
                            cartProvider.clearOnLigneCart();
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          },
                          context: context);
                    },
                    icon: Icon(IconlyBroken.delete, color: couleur))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height * 0.1,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              onTap: () async {
                                User? user = auth.currentUser;
                                final idCommande = const Uuid().v4();
                                // final idLigneCommande = const Uuid().v4();
                                final productProvider =
                                    Provider.of<ProductsProvider>(context,
                                        listen: false);

                                cartProvider.getCartItems
                                    .forEach((key, value) async {
                                  final getCurrentProduct =
                                      productProvider.getProductById(
                                    value.productId,
                                  );
                                  try {
                                    setState(() {
                                      value.quantity;
                                    });

                                    await FirebaseFirestore.instance
                                        .collection('Commandes')
                                        .doc(idCommande)
                                        .set({
                                      'idCommande': idCommande,
                                      'idClient': user!.uid,
                                      'prixTotal': total,
                                      'dateCommande': Timestamp.now(),
                                    });
                                    await FirebaseFirestore.instance
                                        .collection('ligneCommandes')
                                        .doc(getCurrentProduct!.id)
                                        .set({
                                      'idLigneCommande': const Uuid().v4(),
                                      'idCommande': idCommande,
                                      'idProduit': value.productId,
                                      'prix': (getCurrentProduct.isOnSolde
                                              ? getCurrentProduct.solde
                                              : getCurrentProduct.prix) *
                                          value.quantity,
                                      'quantite': value.quantity,
                                      'imageUrl': getCurrentProduct.imageUrl,
                                    });
                                    await cartProvider.clearOnLigneCart();
                                    cartProvider.clearCart();
                                    await ordersProvider.fetchOrders();
                                    await Fluttertoast.showToast(
                                      msg: "Votre commande a été enregistrée",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                    );
                                  } catch (error) {
                                    AlertMessage.messageError(
                                        subTitle: error.toString(),
                                        context: context);
                                  } finally {}
                                });
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: const Padding(
                                padding: EdgeInsets.all(9.0),
                                child: Text(
                                  'Commandez',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        FittedBox(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Total: ${total.toStringAsFixed(2)} DH',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: couleur,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: cartItemsList.length,
                        itemBuilder: (context, index) {
                          return ChangeNotifierProvider.value(
                              value: cartItemsList[index],
                              child: CartWidget(
                                currentQuantite: cartItemsList[index].quantity,
                              ));
                        }),
                  ),
                ],
              ),
            ));
  }
}
