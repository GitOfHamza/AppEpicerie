import 'package:flutter/cupertino.dart';

class PanierModel with ChangeNotifier {
  final String id, productId;
  final int quantity;

  PanierModel({
    required this.id,
    required this.productId,
    required this.quantity,
  });
}
