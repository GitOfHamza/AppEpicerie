import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Consts/firebase_const.dart';
import 'package:flutter_application_1/Screens/Bottom_Bar.dart';
import 'package:flutter_application_1/Services/Alert.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  Future<void> _googleSignIn(context) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          final authResult = await auth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken),
          );
          if (authResult.additionalUserInfo!.isNewUser) {
            await FirebaseFirestore.instance
                .collection('clients')
                .doc(authResult.user!.uid)
                .set({
              'id': authResult.user!.uid,
              'name': authResult.user!.displayName,
              'email': authResult.user!.email,
              // 'password': CryptagePassword().cryptPassword(_passTextController),
              'shipping-address': '',
              'favorites': [],
              'panier': [],
              'dateInscription': Timestamp.now(),
            });
          }
          print(
              "'id': ${authResult.user!.uid} ++ 'name': ${authResult.user!.displayName} ++ 'email': ${authResult.user!.email}");

          Navigator.of(context).pushReplacementNamed('../');
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
    return Material(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        child: InkWell(
          onTap: () {
            _googleSignIn(context);
            // if (emailValide) Navigator.pushNamed(context, '/');
          },
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/google.png',
                  width: 40,
                ),
                const SizedBox(
                  width: 60,
                ),
                const Text(
                  'Connexion via Google',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 19),
                )
              ],
            ),
          ),
        ));
  }
}
