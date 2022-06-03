import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class AlertMessage {
  static Future<void> messageDialog(
      {required String title,
      final String? subTitle,
      required Function fonction,
      required BuildContext context}) async {
    await showDialog(
      context: context,
      builder: (context) {
        final Color couleur = MyTools(context).color;
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                IconlyBold.profile,
                color: Colors.red,
              ),
              const Text('?',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              const SizedBox(width: 8),
              Text(title,
                  style: const TextStyle(
                    fontSize: 15,
                  ))
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('Annuler',
                    style: TextStyle(
                      color: couleur,
                    ))),
            TextButton(
                onPressed: () {
                  fonction();
                },
                child: Text('Oui',
                    style: TextStyle(
                      color: couleur,
                    ))),
          ],
        );
      },
    );
  }

  static Future<void> messageError(
      {required String subTitle, required BuildContext context}) async {
    await showDialog(
      context: context,
      builder: (context) {
        final Color couleur = MyTools(context).color;
        return AlertDialog(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.error_outline_outlined,
                    color: Colors.red,
                  ),
                  Text(' Erreur... ',
                      maxLines: 5,
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      )),
                ],
              ),
              Text('\n' + subTitle,
                  maxLines: 5,
                  style: const TextStyle(
                    fontSize: 15,
                  ))
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('OK',
                    style: TextStyle(
                      color: couleur,
                    ))),
          ],
        );
      },
    );
  }


  static Future<void> notication(
      {required String contenue, required BuildContext context}) async {
    await showDialog(
      context: context,
      builder: (context) {
        final Color couleur = MyTools(context).color;
        return AlertDialog(
          title: Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(contenue,
                    maxLines: 5,
                    style: const TextStyle(
                      fontSize: 17,
                    ))
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text('OK',
                    style: TextStyle(
                      color: couleur,
                    ))),
          ],
        );
      },
    );
  }
}
