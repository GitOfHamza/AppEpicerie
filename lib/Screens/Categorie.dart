import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Widgets/Categorie_Widget.dart';

class CategoriePage extends StatelessWidget {
  CategoriePage({Key? key}) : super(key: key);

  List<Map<String, dynamic>> catInfo = [
    {
      'imgPath': 'assets/images/Fruits.jpg',
      'catText': 'Fruits',
    },
    {
      'imgPath': 'assets/images/Vegetables.jpg',
      'catText': 'Vegetables',
    },
    {
      'imgPath': 'assets/images/Herbs.jpg',
      'catText': 'Herbes',
    },
    {
      'imgPath': 'assets/images/Nuts.jpg',
      'catText': 'Nuts',
    },
    {
      'imgPath': 'assets/images/Spices.jpg',
      'catText': 'Spices',
    },
    {
      'imgPath': 'assets/images/Grains.jpg',
      'catText': 'Grains',
    },
  ];

  List<Color> randomColor = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD380E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 15, // Espace Horizontale
              crossAxisSpacing: 12, // Espace Verticale
              childAspectRatio: 245 / 250,
              children: List.generate(6, (index) {
                return CategoriesWidget(
                  catText: catInfo[index]['catText'],
                  imgPath: catInfo[index]['imgPath'],
                  catColor: randomColor[index],
                );
              }),
            )));
  }
}
