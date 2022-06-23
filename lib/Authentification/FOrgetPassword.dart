import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Consts/ImageAutoScrolle.dart';
import 'package:flutter_application_1/Consts/firebase_const.dart';
import 'package:flutter_application_1/Services/Alert.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_application_1/Widgets/BackLastPage.dart';
import 'package:flutter_application_1/Widgets/SubmitButton.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _emailTextController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();
  // bool _isLoading = false;
  @override
  void dispose() {
    _emailTextController.dispose();

    super.dispose();
  }

  Future<void> _forgetPassFCT() async {
    if (_emailTextController.text.isEmpty ||
        !_emailTextController.text.contains("@") ||
        !_emailTextController.text.contains(".")) {
      AlertMessage.messageError(
          subTitle: 'S\'il vous plaît, mettez une adresse email valide',
          context: context);
    } else {
      if (user != null && _emailTextController.text == user!.email) {
        AlertMessage.messageError(
            subTitle: 'Veuillez déconnecter', context: context);
      } else {
        try {
          await auth.sendPasswordResetEmail(
              email: _emailTextController.text.toLowerCase().trim());
          print(
              "email issssssssssssssssssssssss :${_emailTextController.text}");
          Fluttertoast.showToast(
            msg: "Veuillez consultez votre Boite-Email",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.grey.shade600,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } on FirebaseException catch (erreur) {
          AlertMessage.messageError(subTitle: '$erreur', context: context);
        } catch (erreur) {
          AlertMessage.messageError(subTitle: '$erreur', context: context);
        } finally {}
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MyTools(context).getScreenSize;
    return Scaffold(
      // backgroundColor: Colors.blue,
      body: Stack(
        children: [
          Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.asset(
                ImageAutoScrolle.vipImage[index],
                fit: BoxFit.cover,
              );
            },
            autoplay: true,
            itemCount: ImageAutoScrolle.vipImage.length,
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.1,
                ),
                const BackLastPage(),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Mot de passe Oublié',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: _emailTextController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Email address',
                    hintStyle: TextStyle(color: Colors.white),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SubmitButton(
                  textButton: 'Réinitialiser maintenant',
                  fonction: () async {
                    await _forgetPassFCT();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
