import 'package:card_swiper/card_swiper.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Consts/ImageAutoScrolle.dart';
import 'package:flutter_application_1/Services/tools.dart';
import 'package:flutter_application_1/Widgets/SubmitButton.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final _fullNameController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passTextController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _passFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();
  bool _obscureText = true;
  @override
  void dispose() {
    _fullNameController.dispose();
    _emailTextController.dispose();
    _passTextController.dispose();
    _addressTextController.dispose();
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  bool _isLoading = false;
  void _submitFormOnRegister() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyTools(context).getTheme;
    Color color = MyTools(context).color;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Swiper(
            duration: 800,
            autoplayDelay: 6000,

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
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                const SizedBox(
                  height: 60.0,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () =>
                      Navigator.canPop(context) ? Navigator.pop(context) : null,
                  child: Icon(
                    IconlyLight.arrowLeft2,
                    color: theme == true ? Colors.white : Colors.black,
                    size: 24,
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                const Text(
                  'Bienvenue',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Inscrivez-vous pour continuer',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_emailFocusNode),
                        keyboardType: TextInputType.name,
                        controller: _fullNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Ce champ est manquant";
                          } else {
                            return null;
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Nom Complet',
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
                        height: 20,
                      ),
                      TextFormField(
                        focusNode: _emailFocusNode,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () =>
                            FocusScope.of(context).requestFocus(_passFocusNode),
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailTextController,
                        validator: (value) {
                          if (value!.isEmpty ||
                              !value.contains("@") ||
                              !value.contains('.')) {
                            return 'S\'il vous plaît, mettez une adresse email valide';
                          } else {
                            return null;
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Email',
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
                        height: 20,
                      ),

                      //Password

                      TextFormField(
                        focusNode: _passFocusNode,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passTextController,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return 'S\'il vous plaît, mettez un mot de passe valide.\nDoivent contient plus que 6 charactères.';
                          } else {
                            return null;
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        onEditingComplete: () => FocusScope.of(context)
                            .requestFocus(_addressFocusNode),
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                          ),
                          hintText: 'Mot de passe',
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        focusNode: _addressFocusNode,
                        textInputAction: TextInputAction.done,
                        onEditingComplete: _submitFormOnRegister,
                        controller: _addressTextController,
                        validator: (value) {
                          if (value!.isEmpty || value.length < 10) {
                            return 'S\'il vous plaît, mettez une adresse valide.';
                          } else {
                            return null;
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        decoration: const InputDecoration(
                          hintText: 'Adresse de livraison',
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
                    ],
                  ),
                ),             
                const SizedBox(
                  height: 20,
                ),
                SubmitButton(
                  textButton: 'Inscrivez-vous',
                  fonction: () {
                    _submitFormOnRegister();
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                      text: 'Déjà utilisateur ?',
                      style: const TextStyle(color: Colors.white, fontSize: 19),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Se connecter',
                            style: const TextStyle(
                                color: Colors.lightBlue, fontSize: 19),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                    context, '/Login');
                              }),
                      ]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}