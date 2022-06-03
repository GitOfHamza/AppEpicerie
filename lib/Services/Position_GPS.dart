import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class CurrentPosition  {
  var _latitude = "";
  var _longitude = "";
  
  Future<void> getCurrentLocation(TextEditingController textAddressControler, BuildContext context) async {
    Position pos = await _determinePosition(context);

      _latitude = pos.latitude.toString();
      _longitude = pos.longitude.toString();
      textAddressControler.text = '$_latitude, $_longitude';

  }

  Future<Position> _determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showErrorLocationDialog(
          'Les autorisations de localisation sont désactivées', context);
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showErrorLocationDialog(
            'Les autorisations de localisation sont refusées',context);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _showErrorLocationDialog(
          'Les autorisations de localisation sont définitivement refusées, nous ne pouvons pas demander d\'autorisations.',context);
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> _showErrorLocationDialog(String msg , BuildContext context) async {
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