import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Consts/ImageAutoScrolle.dart';
import 'package:flutter_application_1/Consts/firebase_const.dart';
import 'package:flutter_application_1/Providers/List_Of_Products.dart';
import 'package:flutter_application_1/Providers/Panier-Provider.dart';
import 'package:flutter_application_1/Providers/Wishlist_Provider.dart';
import 'package:flutter_application_1/Providers/order_provider.dart';
import 'package:flutter_application_1/Screens/Bottom_Bar.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:provider/provider.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen> {
  @override
  void initState() {
    
    Future.delayed(const Duration(microseconds: 5), () async {
      final productsProvider =
          Provider.of<ProductsProvider>(context, listen: false);
      final cartProvider = Provider.of<PanierProvider>(context, listen: false);
      final favoriteProvider =
          Provider.of<WishlistProvider>(context, listen: false);
      final ordersProvider =
          Provider.of<OrdersProvider>(context, listen: false);
      final User? user = auth.currentUser;
      
      if (user == null) {
        await productsProvider.fetchProducts();
        cartProvider.clearCart();
        favoriteProvider.clearWishlist();
        ordersProvider.clearOrders();
      } else {
        await productsProvider.fetchProducts();
        await cartProvider.fetchCart();
        await favoriteProvider.fetchWishlist();
        await ordersProvider.fetchOrders();
      }

      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (ctx) => const BottomBar(),
      ));
    });

    // Notification

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/Background_Of_StartingApp.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.grey.shade400,
              ),
              const SizedBox(
                height: 13,
              ),
              Text(
                'Connexion...',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 17),
              )
            ],
          ))
        ],
      ),
    );
  }
}
