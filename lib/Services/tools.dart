import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Providers/Dark_Theme_Provider.dart';
import 'package:provider/provider.dart';

class MyTools {
  BuildContext context;
  MyTools(this.context);

  bool get getTheme => Provider.of<DarkThemeProvider>(context).getDarkTheme;
  Color get color => getTheme ? Colors.white: Colors.black;
  Size get getScreenSize => MediaQuery.of(context).size;
}
