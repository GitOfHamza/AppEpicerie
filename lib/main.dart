import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Authentification/FOrgetPassword.dart';
import 'package:flutter_application_1/Authentification/Login.dart';
import 'package:flutter_application_1/Authentification/Register.dart';
import 'package:flutter_application_1/Consts/Theme_data.dart';
import 'package:flutter_application_1/Consts/firebase_const.dart';
import 'package:flutter_application_1/Inner_InkWell/Browse_All.dart';
import 'package:flutter_application_1/Inner_InkWell/DetailleOfProduct.dart';
import 'package:flutter_application_1/Inner_InkWell/Search_From_Cat%C3%A9gorie.dart';
import 'package:flutter_application_1/Inner_InkWell/Show_All.dart';
import 'package:flutter_application_1/Orders/OrdersPage.dart';
import 'package:flutter_application_1/Providers/Dark_Theme_Provider.dart';
import 'package:flutter_application_1/Providers/History_Provider.dart';
import 'package:flutter_application_1/Providers/List_Of_Products.dart';
import 'package:flutter_application_1/Providers/Panier-Provider.dart';
import 'package:flutter_application_1/Providers/Wishlist_Provider.dart';
import 'package:flutter_application_1/Providers/order_provider.dart';
import 'package:flutter_application_1/Screens/Bottom_Bar.dart';
import 'package:flutter_application_1/Screens/HomeScreen.dart';
import 'package:flutter_application_1/Services/fetch_Screen.dart';
import 'package:flutter_application_1/Services/local_notication_manager.dart';
import 'package:flutter_application_1/Services/push_notication_manager.dart';
import 'package:flutter_application_1/Wishlist/WishlistPage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

/** Welcome to Main File  */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PushNotificationManager().init();
  // Stripe.publishableKey = "pk_test_51L8kNZFMadAtuQRrBQIVcW8DXbImFcWVMUxEJYMM3QERNJx6STlasDk4m7xMtz71lAf4p826s9JWnoSUKxl00kfq00MiOGIOcf";
  // Stripe.instance.applySettings();
  return runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

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
    super.initState();
    getCurrentTheme();
    
  }



  final Future<FirebaseApp> _firebaseInitialisation = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _firebaseInitialisation,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text('Une erreur s\'est produite'),
              ),
            ),
          );
        }
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) {
              return darkThemeProvider;
            }),
            ChangeNotifierProvider(create: (_) {
              return ProductsProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return PanierProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return WishlistProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return ViewedProductProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return OrdersProvider();
            }),
            ChangeNotifierProvider(create: (_) {
              return PushNotificationManager();
            }),
            // ChangeNotifierProvider(create: (_) {
            //   return LocalNotificationService();
            // }),
          ],
          child: Consumer<DarkThemeProvider>(
            builder: (context, themeProvider, child) => MaterialApp(
              initialRoute: '/',
              onGenerateRoute: (settings) =>
                  RouteGenarator.generateRoute(settings),
              debugShowCheckedModeBanner: false,
              theme: Styles.themeData(themeProvider.getDarkTheme, context),
              home: const FetchScreen(),
            ),
          ),
        );
      },
    );
  }
}

/****************************** ROUTAGE ***************************************/

class RouteGenarator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '../':
        return MaterialPageRoute(builder: (context) => const FetchScreen());
      case '/':
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case '/All_Soldes':
        return MaterialPageRoute(builder: (context) => const ShowAll());
      case '/All_Products':
        return MaterialPageRoute(builder: (context) => const BrowseAll());
      case 'ProductByCategory':
        return MaterialPageRoute(
            builder: (context) => const ProductByCategory());
      case '/WishlistPage':
        return MaterialPageRoute(builder: (context) => const WishlistPage());
      case '/OrdersPage':
        return MaterialPageRoute(builder: (context) => const OrdersPage());
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
