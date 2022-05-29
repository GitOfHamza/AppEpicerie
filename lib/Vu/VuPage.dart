import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/Alert.dart';
import 'package:flutter_application_1/Services/EmptyPage.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_application_1/Vu/VuWidget.dart';
import 'package:flutter_application_1/Widgets/BackLastPage.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class VuPage extends StatefulWidget {
  const VuPage({Key? key}) : super(key: key);

  @override
  State<VuPage> createState() => _VuPageState();
}

class _VuPageState extends State<VuPage> {
  @override
  Widget build(BuildContext context) {
    Color couleur = MyTools(context).color;
    bool isEmptyPage = false;
    return isEmptyPage
        ? EmptyPage(
            imagePath: 'assets/images/ensembleVide.png',
            message: 'Aucun produit n\'a encore été consulté',
            textButton: 'Achetez maintenant',
            fonction: () {
              Navigator.pushNamed(context, '/All_Products');
            })
        : Scaffold(
      appBar: AppBar(
        title: Text('Histrorique',
            style: TextStyle(
                color: couleur, fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        leading: const BackLastPage(),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              AlertMessage.messageDialog(
                  title: 'Voulez vous vidé Historique?',
                  subTitle: '',
                  fonction: () {},
                  context: context);
            },
            icon: Icon(
              IconlyBroken.delete,
              color: couleur,
            ),
          )
        ],
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
      ),
      body: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
          child: VuWidget(),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: couleur,
            thickness: 1.0,
          );
        },
      ),
    );
  }
}
