import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Panier/CartWidget.dart';
import 'package:flutter_application_1/Services/Alert.dart';
import 'package:flutter_application_1/Services/EmptyPage.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color couleur = MyTools(context).color;
    Size size = MyTools(context).getScreenSize;
    bool isEmptyPage = false;
    return isEmptyPage ?  EmptyPage(
      imagePath: 'assets/images/ensembleVide.png',
      message: 'Pas encore d\'articles dans votre panier',
      textButton: 'Achetez maintenant',
      fonction: (){
        Navigator.pushNamed(context, '/All_Products');
      }
    ) : Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'Cart (10)',
            style: TextStyle(color: couleur, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  AlertMessage.messageDialog(
                      title: 'Voullez vous vidé le panier?',
                      subTitle: '',
                      fonction: () {},
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
                          onTap: () {
                            Navigator.pushNamed(context, '/DetailleOfProduct');
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: const Padding(
                            padding: EdgeInsets.all(9.0),
                            child: Text(
                              'Commandez',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
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
                          'Total: 110 DH',
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
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const CartWidget();
                    }),
              ),
            ],
          ),
        ));
  }
}