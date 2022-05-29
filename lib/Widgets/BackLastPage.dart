import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class BackLastPage extends StatelessWidget {
  const BackLastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color couleur = MyTools(context).color;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => Navigator.canPop(context) ? Navigator.pop(context) : null,
      child: Icon(
        IconlyLight.arrowLeft2,
        color: couleur,
        size: 24,
      ),
    );
  }
}
