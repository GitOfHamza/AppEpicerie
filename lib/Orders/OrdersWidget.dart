import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Inner_InkWell/DetailleOfProduct.dart';
import 'package:flutter_application_1/Models/order_model.dart';
import 'package:flutter_application_1/Providers/List_Of_Products.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:provider/provider.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late String orderDateToShow;

  @override
  void didChangeDependencies() {
    final ordersModel = Provider.of<OrderModel>(context);
    var orderDate = ordersModel.orderDate.toDate();
    orderDateToShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = MyTools(context).color;
    Size size = MyTools(context).getScreenSize;
    final ordersModel = Provider.of<OrderModel>(context);
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrentProduct =
        productProvider.getProductById(ordersModel.productId);
    return ListTile(
        subtitle: Text(
            'Payé: ${double.parse(ordersModel.price).toStringAsFixed(2)} DH'),
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  DetailleOfProduct(productId: getCurrentProduct!.id),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                animation =
                    CurvedAnimation(parent: animation, curve: Curves.ease);
                return FadeTransition(opacity: animation, child: child);
              },
            ),
          );
        },
        leading: FancyShimmerImage(
          width: size.width * 0.2,
          imageUrl: getCurrentProduct!.imageUrl,
          boxFit: BoxFit.fill,
        ),
        title: Text(
          '${getCurrentProduct.title}  x${ordersModel.quantity}',
          style: TextStyle(color: color, fontSize: 18),
        ),
        trailing: Text(
          orderDateToShow,
          style: TextStyle(color: color, fontSize: 18),
        ));
  }
}
