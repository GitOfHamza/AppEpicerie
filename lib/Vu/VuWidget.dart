import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/tools.dart';

class VuWidget extends StatefulWidget {
  const VuWidget({Key? key}) : super(key: key);

  @override
  State<VuWidget> createState() => _VuWidgetState();
}

class _VuWidgetState extends State<VuWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MyTools(context).getScreenSize;
    Color couleur = MyTools(context).color;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/DetailleOfProduct');
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FancyShimmerImage(
              height: size.width * 0.2,
              width: size.width * 0.25,
              imageUrl:
                  'http://assets.stickpng.com/images/580b57fcd9996e24bc43c12b.png',
              boxFit: BoxFit.fill,
            ),
            const SizedBox(width: 12,),
            Column(
              children: [
                Text(
                  'Titre',
                  style: TextStyle(
                    color: couleur,
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(height: 12,),
                Text(
                  'sousTitre',
                  style: TextStyle(
                    color: couleur,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: moveToCart(
                fct: () {
                  setState(() {
                  });
                },
                icon: CupertinoIcons.plus,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget moveToCart(
      {required Function fct, required IconData icon, required Color color}) {
    return Flexible(
      flex: 2,
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: color,
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
            )),
      ),
    );
  }
}

