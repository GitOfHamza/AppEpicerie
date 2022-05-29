import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color couleur = MyTools(context).color;
    Size size = MyTools(context).getScreenSize;
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/DetailleOfProduct');
        },
        child: Container(
          height: size.height * 0.2,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(1.0),
            border: Border.all(color: couleur, width: 0.5),
            borderRadius: BorderRadius.circular(8)
          ),
          child: Row(
            children: [
                 Container(
                  margin: const EdgeInsets.only(left: 8),
                  width: size.width * 0.2,
                  height: size.width * 0.25,
                  child: FancyShimmerImage(
                          imageUrl:'http://assets.stickpng.com/images/580b57fcd9996e24bc43c12b.png',
                          boxFit: BoxFit.fill,
                        ),
                ),
              Flexible(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          const SizedBox(width:14),
                          IconButton(
                                onPressed: () {},
                                icon: Icon(IconlyLight.bag2, color: couleur),
                              ),
                          GestureDetector(
                                onTap: () {},
                                child:
                                    Icon(IconlyLight.heart, color: couleur),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Text(
                        'Title', style: TextStyle(color: couleur, fontSize: 20 ),maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 7,),
                    Flexible(
                      child: Text(
                        '11 DH', style: TextStyle(color: couleur, fontSize: 20),maxLines: 1,
                    ),
                  )
                  ],
                ),
              )
            ],
          )
        )),
    );
  }
}
