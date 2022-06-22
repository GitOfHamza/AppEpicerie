import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Consts/firebase_const.dart';
import 'package:flutter_application_1/Providers/Dark_Theme_Provider.dart';
import 'package:flutter_application_1/Providers/order_provider.dart';
import 'package:flutter_application_1/Services/Alert.dart';
import 'package:flutter_application_1/Services/Position_GPS.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final TextEditingController textAddressControler =
      TextEditingController(text: '');

  String? _email;
  String? _name;
  String? address;
  bool _isLoading = false;
  final User? user = auth.currentUser;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    try {
      if (user == null) {
        setState(() {
          _isLoading = false;
        });
        return;
      } else {
        String _uid = user!.uid;
        setState(() {
          _isLoading = true;
        });

        final DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('clients')
            .doc(_uid)
            .get();
        if (userDoc == null) {
          return;
        } else {
          _email = userDoc.get('email');
          _name = userDoc.get('name');
          address = userDoc.get('shipping-address');
          textAddressControler.text = userDoc.get('shipping-address');
        }
      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      AlertMessage.messageError(subTitle: error.toString(), context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /************************************* Location ***************************************/

  /***************************************************************************************/

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _login = (user == null && _isLoading == false) ? false : true;

    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          )
        : Scaffold(
            body: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(7),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Icon(
                              Icons.account_circle_outlined,
                              size: 65,
                              color: themeState.getDarkTheme
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(_login ? _name! : 'Vous étes invité',
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 8,
                                ),
                                Visibility(
                                    visible: _login,
                                    child: Text(_login ? _email! : '')),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Divider(thickness: 2),
                      const SizedBox(
                        height: 20,
                      ),
                      _list_infos(
                          title: 'Adresse',
                          subTitle: textAddressControler.text,
                          icon: IconlyLight.location,
                          onClick: () async {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Adresse'),
                                    content: TextField(
                                        controller: textAddressControler,
                                        onChanged: (value) {
                                          textAddressControler.text;
                                        },
                                        decoration: const InputDecoration(
                                            hintText:
                                                'Votre adresse actuelle')),
                                    actions: [
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            fixedSize: Size.fromWidth(160)),
                                        onPressed: () async {
                                          await CurrentPosition()
                                              .getCurrentLocation(
                                                  textAddressControler,
                                                  context);
                                          // Navigator.of(context).pop(true);
                                        },
                                        child: Row(
                                          children: const [
                                            Icon(Icons.location_on),
                                            Text('Position Actuelle')
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                          onPressed: () async {
                                            String _uid = user!.uid;
                                            try {
                                              await FirebaseFirestore.instance
                                                  .collection('clients')
                                                  .doc(_uid)
                                                  .update({
                                                'shipping-address':
                                                    textAddressControler.text,
                                              });

                                              setState(() {
                                                address =
                                                    textAddressControler.text;
                                              });
                                              Navigator.of(context).pop(true);
                                            } catch (error) {
                                              AlertMessage.messageError(
                                                  subTitle: error.toString(),
                                                  context: context);
                                            }
                                          },
                                          child: const Text('Validé')),
                                    ],
                                  );
                                });
                          }),
                      _list_infos(
                          title: 'Ordres',
                          icon: IconlyLight.bag,
                          onClick: () {
                            Navigator.pushNamed(context, '/OrdersPage');
                          }),
                      _list_infos(
                          title: 'Liste de souhaits',
                          icon: IconlyLight.heart,
                          onClick: () {
                            Navigator.pushNamed(context, '/WishlistPage');
                          }),
                      // _list_infos(
                      //     title: 'Historique',
                      //     icon: Icons.history_outlined,
                      //     onClick: () {
                      //       Navigator.pushNamed(context, '/VuPage');
                      //     }),
                      _list_infos(
                          title: 'Mot de passe oublié',
                          icon: IconlyLight.unlock,
                          onClick: () {
                            Navigator.pushNamed(context, '/ForgetPassword');
                          }),
                      SwitchListTile(
                        activeColor: Colors.white,
                        title: const Text('Théme',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
                        secondary: Icon(themeState.getDarkTheme
                            ? Icons.dark_mode_outlined
                            : Icons.light_mode_outlined),
                        onChanged: (bool value) {
                          setState(() {
                            themeState.setDarkTheme = value;
                          });
                        },
                        value: themeState.getDarkTheme,
                      ),
                      _list_infos(
                          title: _login ? 'Se déconnecter' : 'Se connecter',
                          icon: _login ? IconlyLight.logout : IconlyLight.login,
                          onClick: () {
                            !_login
                                ? Navigator.pushNamed(context, '/Login')
                                : AlertMessage.messageDialog(
                                    title: 'Voullez vous déconnecter?',
                                    subTitle: '',
                                    fonction: () async {
                                      await auth.signOut();
                                      _login = false;
                                      Navigator.pushNamed(context, '/Login');
                                    },
                                    context: context);
                          }),
                    ]),
              ),
            ),
          );
  }

  Widget _list_infos(
      {required String title,
      String? subTitle,
      required IconData icon,
      required Function onClick}) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    return ListTile(
        title: Text(title,
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
        subtitle: Text(subTitle == null ? '' : subTitle),
        trailing: const Icon(Icons.arrow_forward_ios_outlined),
        leading: Icon(
          icon,
          size: 27,
          color: themeState.getDarkTheme ? Colors.white : Colors.black,
        ),
        onTap: () {
          onClick();
        });
  }
}
