import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Consts/ImageAutoScrolle.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_application_1/Widgets/BackLastPage.dart';
import 'package:flutter_application_1/Widgets/SubmitButton.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

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

  void _submitFormOfForgetPassword() {
    final isValid = _keyForm.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      print('Le Text est Bien Validé ################');
    }
  }

  bool _isLoading = false;
  void _forgetPassFCT() async {}

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

            // control: const SwiperControl(),
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
                TextFormField(
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () {
                    _submitFormOfForgetPassword();
                  },
                  validator: (valeur) {
                    if (valeur!.isEmpty ||
                        !valeur.contains('@') ||
                        !valeur.contains('.')) {
                      return 'S\'il vous plaît, mettez une adresse email valide';
                    } else {
                      return null;
                    }
                  },
                  style: const TextStyle(color: Colors.white, fontSize: 21),
                  decoration: const InputDecoration(
                    hintText: 'Email adresse',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 21),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                  controller: _emailTextController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 15,
                ),
                SubmitButton(
                  textButton: 'Réinitialiser maintenant',
                  fonction: () {
                    // _submitFormOfForgetPassword();
                    _forgetPassFCT();
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
