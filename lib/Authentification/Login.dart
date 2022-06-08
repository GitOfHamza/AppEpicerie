import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Consts/ImageAutoScrolle.dart';
import 'package:flutter_application_1/Consts/firebase_const.dart';
import 'package:flutter_application_1/Screens/Bottom_Bar.dart';
import 'package:flutter_application_1/Services/Alert.dart';
import 'package:flutter_application_1/Services/fetch_Screen.dart';
import 'package:flutter_application_1/Widgets/GoogleButton.dart';
import 'package:flutter_application_1/Widgets/SubmitButton.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  var _isObscure = true;
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  void _submitFormOfLogin() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    // Authentification du client gérer par FireBase
    if (isValid) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await auth.signInWithEmailAndPassword(
            email: emailController.text.toLowerCase().trim(),
            password: passwordController.text.trim());
        
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const FetchScreen(),
        ));
      } on FirebaseException catch (erreur) {
        setState(() {
          _isLoading = false;
        });
        AlertMessage.messageError(subTitle: '$erreur', context: context);
      } catch (erreur) {
        setState(() {
          _isLoading = false;
        });
        AlertMessage.messageError(subTitle: '$erreur', context: context);
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Swiper(
            duration: 800,
            autoplayDelay: 4000,
            itemBuilder: (context, index) {
              return Image.asset(
                ImageAutoScrolle.vipImage[index],
                fit: BoxFit.fill,
              );
            },
            autoplay: true,
            itemCount: ImageAutoScrolle.vipImage.length,
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  const Text(
                    'Bienvenue sur votre Epicerie',
                    style: TextStyle(
                        // fontFamily: 'Satisfy',
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Connectez-vous pour continuer',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // ----------------------- Email -----------------------------
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(passwordFocus),
                          validator: (valeur) {
                            if (valeur!.isEmpty ||
                                !valeur.contains('@') ||
                                !valeur.contains('.')) {
                              return 'S\'il vous plaît, mettez une adresse email valide';
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(
                              color: Colors.white, fontSize: 21),
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            hintStyle:
                                TextStyle(color: Colors.white, fontSize: 21),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        // ----------------------- Password -----------------------------
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          onEditingComplete: () {
                            _submitFormOfLogin();
                          },
                          validator: (valeur) {
                            if (valeur!.isEmpty || valeur.length < 6) {
                              return 'S\'il vous plaît, mettez un mot de passe valide.\nDoivent contient plus que 6 charactères.';
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(
                              color: Colors.white, fontSize: 21),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                              child: Icon(
                                _isObscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.grey.shade400,
                              ),
                            ),
                            hintText: 'Mot de passe',
                            hintStyle: const TextStyle(
                                color: Colors.white, fontSize: 21),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            disabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                          ),
                          controller: passwordController,
                          focusNode: passwordFocus,
                          obscureText: _isObscure,
                          keyboardType: TextInputType.visiblePassword,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/ForgetPassword');
                        },
                        child: Text(
                          'Mot_de_passe_oublié',
                          style: TextStyle(
                              color: Colors.blue.shade400,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic),
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : SubmitButton(
                          textButton: 'Se Connecter',
                          fonction: () {
                            _submitFormOfLogin();
                          }),
                  const SizedBox(
                    height: 15,
                  ),
                  GoogleButton(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Divider(
                        thickness: 2,
                        color: Colors.grey.shade400,
                      )),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'OU',
                        style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: Divider(
                        thickness: 2,
                        color: Colors.grey.shade400,
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SubmitButton(
                    textButton: 'Continuer en tant qu\'invité',
                    fonction: () {
                      Navigator.pushNamed(context, '../');
                    },
                    couleur: Colors.black87,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                      text: TextSpan(
                          text: 'Vous n\'avez pas de compte ?',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 19),
                          children: [
                        TextSpan(
                            text: '   S\'inscrire',
                            style: const TextStyle(
                                color: Colors.lightBlue,
                                fontSize: 19,
                                fontWeight: FontWeight.bold),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(context, '/Register');
                              }),
                      ]))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
