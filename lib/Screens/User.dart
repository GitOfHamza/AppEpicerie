import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Providers/Dark_Theme_Provider.dart';
import 'package:flutter_application_1/Services/Alert.dart';
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
  var _latitude = "";
  var _longitude = "";

  /************************************* Location ***************************************/

  Future<void> getCurrentLocation() async {
    Position pos = await _determinePosition();
    setState(() {
      _latitude = pos.latitude.toString();
      _longitude = pos.longitude.toString();
      textAddressControler.text = '$_latitude, $_longitude';
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showErrorLocationDialog(
          'Les autorisations de localisation sont désactivées');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showErrorLocationDialog(
            'Les autorisations de localisation sont refusées');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _showErrorLocationDialog(
          'Les autorisations de localisation sont définitivement refusées, nous ne pouvons pas demander d\'autorisations.');
    }
    return await Geolocator.getCurrentPosition();
  }

  /***************************************************************************************/

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    bool _login = true;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(7),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('Hamza ELKADDARI',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 8,
                        ),
                        Text('hamza@gmail.com'),
                      ],
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
                                      hintText: 'Votre adresse actuelle')),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                      fixedSize: Size.fromWidth(160)),
                                  onPressed: () async {
                                    await getCurrentLocation();
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
                                    onPressed: () {
                                      setState(() {
                                        textAddressControler.text;
                                      });
                                      Navigator.of(context).pop(true);
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
                _list_infos(
                    title: 'Vu',
                    icon: IconlyLight.show,
                    onClick: () {
                      Navigator.pushNamed(context, '/VuPage');
                    }),
                _list_infos(
                    title: 'Mot de passe oublié',
                    icon: IconlyLight.unlock,
                    onClick: () {
                      Navigator.pushNamed(context, '/ForgetPassword');
                    }),
                SwitchListTile(
                  activeColor: Colors.cyan,
                  title: const Text('Théme',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
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
                    title: 'Se connecter',
                    icon: IconlyLight.login,
                    onClick: () {
                      _login
                          ? Navigator.pushNamed(context, '/Login')
                          : AlertMessage.messageDialog(
                              title: 'Voullez vous déconnecter?',
                              subTitle: '',
                              fonction: () {
                                // Navigator.pushNamed(context, '/Login');
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

  Future<void> _showErrorLocationDialog(String msg) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(msg),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('OK')),
          ],
        );
      },
    );
  }
}
