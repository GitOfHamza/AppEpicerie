// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_string_encryption/flutter_string_encryption.dart';

// class CryptagePassword {
//   String? encrypt, decrypt;
//   PlatformStringCryptor platformStringCryptor = PlatformStringCryptor();

//   Future<String> cryptPassword(TextEditingController password) async {
//     final pointer = await platformStringCryptor.generateSalt();
//     return await platformStringCryptor.encrypt(
//         password.text,
//         await platformStringCryptor.generateKeyFromPassword(
//             password.text, pointer));
//   }

//   Future<String> decryptPassword(
//       TextEditingController password, String hashedPassword) async {
//     try {
//       final pointer = await platformStringCryptor.generateSalt();
//       return await platformStringCryptor.decrypt(
//           hashedPassword,
//           await platformStringCryptor.generateKeyFromPassword(
//               password.text, pointer));
//     } on MacMismatchException {
//       return 'Erreur Decrypted';
//     }
//   }
// }
