import 'package:flutter/material.dart';
import 'package:flutter_application_1/Consts/firebase_const.dart';
import 'package:flutter_application_1/Orders/OrdersWidget.dart';
import 'package:flutter_application_1/Providers/order_provider.dart';
import 'package:flutter_application_1/Services/EmptyPage.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_application_1/Widgets/BackLastPage.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    final Color color = MyTools(context).color;
    Size size = MyTools(context).getScreenSize;
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final ordersList = ordersProvider.getOrders;
    return ordersList.isEmpty
        ? EmptyPage(
            imagePath: 'assets/images/commandeVide.png',
            message: 'Vous n\'avez pas encore passé de commande',
            textButton: 'Achetez maintenant',
            fonction: () {
              Navigator.pushNamed(context, '/All_Products');
            })
        : Scaffold(
            appBar: AppBar(
              leading: const BackLastPage(),
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Votre commandes (${ordersList.length})',
                style: TextStyle(
                    color: color, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
            ),
            body: ListView.separated(
              itemCount: ordersList.length,
              itemBuilder: (ctx, index) {
                return Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    child: ChangeNotifierProvider.value(
                        value: ordersList[index], child: const OrderWidget()));
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: color,
                  thickness: 0.5,
                );
              },
            ));
  }
}
