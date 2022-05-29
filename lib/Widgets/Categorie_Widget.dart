// import 'dart:html';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Providers/Dark_Theme_Provider.dart';
import 'package:provider/provider.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget(
      {Key? key,
      required this.catText,
      required this.catColor,
      required this.imgPath})
      : super(key: key);
  final String catText, imgPath;
  final Color catColor;
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    double _screenWidth = MediaQuery.of(context).size.width;
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;
    return InkWell(
      onTap: () {},
      child: Container(
        height: _screenWidth * 0.65,
        width: _screenWidth * 0.4,
        decoration: BoxDecoration(
          color: catColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: catColor.withOpacity(0.7), width: 2),
        ),
        child: Column(
          children: [
            // const SizedBox(height: 5),
            Container(
              height: _screenWidth * 0.3,
              width: _screenWidth * 0.47,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(17),topRight: Radius.circular(17),),
                  // BorderRadius.circular(17),
                  image: DecorationImage(
                    image: AssetImage(
                      imgPath,
                    ),
                    fit: BoxFit.fill,
                  )),
            ),
            const SizedBox(height: 8),
            Text(catText,
                style: TextStyle(
                    color: color, fontSize: 20, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}
