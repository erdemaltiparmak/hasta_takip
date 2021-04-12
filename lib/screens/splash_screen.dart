import 'package:flutter/material.dart';
import 'package:hasta_takip/screens/UI/main_page.dart';
import 'package:hasta_takip/screens/giris_yap/giris_ekrani.dart';
import 'package:hasta_takip/size_config.dart';
import 'package:hasta_takip/utils/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _SplashScreenState();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2, milliseconds: 50), () {
      getSharedPreferences().then((value) => {
            if (value.getBool('isLogin') == null)
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GirisEkrani()),
                )
              }
            else
              {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                )
              }
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 1,
            ),
            Text(
              "Hasta Takip Sistemi",
              style: TextStyle(
                  color: Colors.green,
                  fontSize: yuksekligeGoreAyarla(context, 40)),
            ),
            Spacer(
              flex: 1,
            ),
            Image.asset('assets/images/splash.png'),
            Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
