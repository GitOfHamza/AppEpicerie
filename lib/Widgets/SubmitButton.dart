import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SubmitButton extends StatelessWidget {
  final Function fonction;
  final String textButton;
  final Color couleur;
  const SubmitButton({Key? key,
  required this.textButton,
  required this.fonction,
  this.couleur = Colors.white38,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.0,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: couleur, // background (button) color
          ),
          onPressed: () {
            fonction();
            // _submitFormOnLogin();
          },
          child: Text(
            textButton,
            style: const TextStyle(
              fontSize: 19,
              color: Colors.white
            ),
          )),
    );
  }
}
