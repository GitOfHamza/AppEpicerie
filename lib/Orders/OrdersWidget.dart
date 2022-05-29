import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:provider/provider.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  // late String orderDateToShow;

  @override
  Widget build(BuildContext context) {
    final Color color = MyTools(context).color;
    Size size = MyTools(context).getScreenSize;
    return ListTile(
      subtitle: const Text('Aricots: 11 DH'),
      onTap: () {
        Navigator.pushNamed(context, '/DetailleOfProduct');
      },
      leading: FancyShimmerImage(
        width: size.width * 0.2,
        imageUrl: 'http://assets.stickpng.com/images/580b57fcd9996e24bc43c12b.png',
        boxFit: BoxFit.fill,
      ),
      title: Text(
          'Abricots  x12',
          style: TextStyle(
            color: color,
            fontSize: 18
          ),),
      trailing: Text(
          '24/05/2022',
          style: TextStyle(
            color: color,
            fontSize: 18
          ),
    )
    );
  }
}
