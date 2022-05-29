import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/tools.dart';

class PriceNameOfProduct extends StatelessWidget {
  final double soldePrix, prix;
  final String? quantite;
  final bool isOnSolde;

  const PriceNameOfProduct({
    Key? key,
    required this.isOnSolde,
    this.soldePrix = 0,
    required this.prix,
    this.quantite = '1',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color couleur = MyTools(context).color;
    double userPrix = isOnSolde ? soldePrix : prix;
    Widget Prix() => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quantite!.isNotEmpty ?'${(userPrix * double.parse(quantite!)).toStringAsFixed(2)} DH' : '0 DH',
              style: const TextStyle(
                color: Colors.green,
                fontSize: 20,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Visibility(
              visible: isOnSolde,
              child: Text(
                '$prix',
                style: TextStyle(
                    color: couleur,
                    fontSize: 15,
                    decoration: TextDecoration.lineThrough),
              ),
            ),
          ],
        );

    return FittedBox(child: Prix());
  }
}
