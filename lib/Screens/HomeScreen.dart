import 'package:card_swiper/card_swiper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Consts/ImageAutoScrolle.dart';
import 'package:flutter_application_1/Providers/Dark_Theme_Provider.dart';
import 'package:flutter_application_1/Screens/Categorie.dart';
import 'package:flutter_application_1/Services/Dark_Theme_Preference.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_application_1/Widgets/Product_Info.dart';
import 'package:flutter_application_1/Widgets/Products.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  @override
  Widget build(BuildContext context) {
    Size __size = MyTools(context).getScreenSize;
    final Color couleur = MyTools(context).color;
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: __size.height * 0.33,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      ImageAutoScrolle.offerImage[index],
                      fit: BoxFit.fill,
                    );
                  },
                  autoplay: true,
                  itemCount: ImageAutoScrolle.offerImage.length,
                  pagination: const SwiperPagination(
                      alignment: Alignment.bottomCenter,
                      builder: DotSwiperPaginationBuilder(
                          color: Colors.white, activeColor: Colors.yellow)),
                  // control: SwiperControl(),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/All_Soldes');
                },
                child: const Text('Voir tout',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                    maxLines: 1),
              ),
              SizedBox(
                height: __size.height * 0.24,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (ctx, index) {
                      return const ProductInfo();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('Notre Produits',
                          style: TextStyle(
                              color: couleur,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          maxLines: 1),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/All_Products');
                      },
                      child: const Text('Parcourir tout',
                          style: TextStyle(color: Colors.blue, fontSize: 20),
                          maxLines: 1),
                    ),
                  ],
                ),
              ),
              GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  // crossAxisSpacing: 2,
                  padding: EdgeInsets.zero,
                  crossAxisCount: 2,
                  childAspectRatio: __size.width / (__size.height * 0.55),
                  children: List.generate(4, (index) {
                    return const Products();
                  })),
            ],
          ),
        ],
      ),
    );
  }
}
