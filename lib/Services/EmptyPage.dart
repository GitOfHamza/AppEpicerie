import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/tools.dart';

class EmptyPage extends StatelessWidget {
  final String imagePath;
  final String message;
  final String textButton;
  final Function fonction;
  const EmptyPage(
      {Key? key,
      required this.imagePath,
      required this.message,
      required this.textButton,
      required this.fonction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool darkTheme = MyTools(context).getTheme;
    Color couleur = MyTools(context).color;
    Size size = MyTools(context).getScreenSize;
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: double.infinity,
                height: size.height * 0.3,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.cyan,
                  fontSize: 22,
                ),
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Theme.of(context).backgroundColor
                    )
                  ),
                  primary: Theme.of(context).colorScheme.secondary,
                  onPrimary: couleur,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                  )
                ),
                  onPressed: () {
                    fonction();
                  },
                  child: Text(
                    textButton,
                    style: TextStyle(
                        color: darkTheme
                            ? Colors.grey.shade300
                            : Colors.grey.shade600,
                        fontSize: 20),
                  ))
            ],
          ),
        ),
    );
  }
}
