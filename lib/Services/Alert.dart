import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class AlertMessage {
  static Future<void> messageDialog({
    required String title,
    required String subTitle,
    required Function fonction,
    required BuildContext context
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
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
                  style:const TextStyle(
                    fontSize: 15,
                  ))
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Annuler')),
            TextButton(
                onPressed: () {
                  fonction();
                },
                child: const Text('Oui')),
          ],
        );
      },
    );
  }
}