import 'package:flutter/material.dart';
import 'package:flutter_application_1/Authentification/FOrgetPassword.dart';
import 'package:flutter_application_1/Authentification/Login.dart';
import 'package:flutter_application_1/Authentification/Register.dart';
import 'package:flutter_application_1/Consts/Theme_data.dart';
import 'package:flutter_application_1/Inner_InkWell/Browse_All.dart';
import 'package:flutter_application_1/Inner_InkWell/DetailleOfProduct.dart';
import 'package:flutter_application_1/Inner_InkWell/Show_All.dart';
import 'package:flutter_application_1/Orders/OrdersPage.dart';
import 'package:flutter_application_1/Providers/Dark_Theme_Provider.dart';
import 'package:flutter_application_1/Screens/Bottom_Bar.dart';
import 'package:flutter_application_1/Screens/HomeScreen.dart';
import 'package:flutter_application_1/Vu/VuPage.dart';
import 'package:flutter_application_1/Wishlist/WishlistPage.dart';
import 'package:provider/provider.dart';

/** Welcome to Main File  */

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider darkThemeProvider = DarkThemeProvider();

  void getCurrentTheme() async {
    darkThemeProvider.setDarkTheme =
        await darkThemeProvider.darkThemePreference.getTheme();
  }

  @override
  void initState() {
    getCurrentTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return darkThemeProvider;
        })
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) => MaterialApp(
          initialRoute: '/',
          onGenerateRoute: (settings) => RouteGenarator.generateRoute(settings),
          debugShowCheckedModeBanner: false,
          theme: Styles.themeData(themeProvider.getDarkTheme, context),
          home: const BottomBar(),
        ),
      ),
    );
  }
}

/****************************** ROUTAGE ***************************************/

class RouteGenarator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/All_Soldes':
        return MaterialPageRoute(builder: (context) => const ShowAll());
      case '/All_Products':
        return MaterialPageRoute(builder: (context) => const BrowseAll());
      case '/DetailleOfProduct':
        return MaterialPageRoute(
            builder: (context) => const DetailleOfProduct());
      case '/WishlistPage':
        return MaterialPageRoute(builder: (context) => const WishlistPage());
      case '/OrdersPage':
        return MaterialPageRoute(builder: (context) => const OrdersPage());
      case '/VuPage':
        return MaterialPageRoute(builder: (context) => const VuPage());
      case '/Login':
        return MaterialPageRoute(builder: (context) => const LoginPage());
      case '/Register':
        return MaterialPageRoute(builder: (context) => const RegisterPage());
      case '/ForgetPassword':
        return MaterialPageRoute(
            builder: (context) => const ForgetPasswordPage());
      default:
        throw const FormatException('Page not found');
    }
  }
}
