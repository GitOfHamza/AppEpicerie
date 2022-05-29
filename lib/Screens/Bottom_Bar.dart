import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Providers/Dark_Theme_Provider.dart';
import 'package:flutter_application_1/Panier/CartPage.dart';
import 'package:flutter_application_1/Screens/Categorie.dart';
import 'package:flutter_application_1/Screens/HomeScreen.dart';
import 'package:flutter_application_1/Screens/User.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectIndex = 2;
  final List<Map<String, dynamic>> _pages = [
    {'page': const HomeScreen(), 'title': 'Acceuil'},
    {'page': CategoriePage(), 'title': 'Catégories'},
    {'page': const CartPage(), 'title': 'Panier'},
    {'page': const UserPage(), 'title': 'Profile'},
  ];
  void pageIndex(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _isDark = themeState.getDarkTheme;
    final tools = MyTools(context);
    Color dynamicColor = tools.color;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     _pages[selectIndex]['title'],
      //     style: TextStyle(color: dynamicColor, fontSize: 24,fontWeight: FontWeight.bold),
      //   ),
      //   elevation: 0,
      //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      // ),
      body: _pages[selectIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _isDark ? Theme.of(context).cardColor : Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: _isDark ? Colors.white30 : Colors.black26,
        unselectedItemColor: _isDark ? Colors.cyan : Colors.black87,
        currentIndex: selectIndex,
        onTap: pageIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(selectIndex == 0 ? IconlyBold.home : IconlyLight.home),
              label: 'Acceuil'),
          BottomNavigationBarItem(
              icon: Icon(selectIndex == 1
                  ? IconlyBold.category
                  : IconlyLight.category),
              label: 'Categories'),
          BottomNavigationBarItem(
              icon: Badge(
                  toAnimate: true,
                  elevation: 10,
                  shape: BadgeShape.circle,
                  badgeColor: Colors.orange.shade700,
                  borderRadius: BorderRadius.circular(8),
                  position: BadgePosition.topEnd(top: -12,end: -10),
                  badgeContent: const Text('1', style: TextStyle(color: Colors.white, fontSize: 13)),
                  child: Icon(selectIndex == 2 ? IconlyBold.buy : IconlyLight.buy)),
              label: 'Panier'),
          BottomNavigationBarItem(
              icon:
                  Icon(selectIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
              label: 'Profile'),
        ],
      ),
    );
  }
}
