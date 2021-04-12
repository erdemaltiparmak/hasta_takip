import 'package:flutter/material.dart';
import 'package:hasta_takip/screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

String currentUser = "";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/splash.png"), context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hasta Takip Sistemi',
      theme: tema(context),
      home: SplashScreen(),
    );
  }
}

ThemeData tema(BuildContext context) {
  return ThemeData(
    //errorColor: Colors.white,
    inputDecorationTheme: _inputDecerationTheme(),
    scaffoldBackgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: "Muli",
    textTheme: TextTheme(
      bodyText1: TextStyle(color: kTextColor),
      bodyText2: TextStyle(color: kTextColor),
    ),
    appBarTheme: AppBarTheme(
      color: Colors.white,
      elevation: 0,
      brightness: Brightness.light,
      iconTheme: IconThemeData(color: kPrimaryColor),
      // textTheme: TextTheme(headline6: TextStyle(color: kPrimaryColor, fontSize: yuksekligeGoreAyarla(context,48)))
    ),
    //inputDecorationTheme: _inputDecoration(context)
  );
}

InputDecorationTheme _inputDecerationTheme() {
  return InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: kTextColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: kTextColor),
    ),
  );
}
