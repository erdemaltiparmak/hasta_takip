import 'package:flutter/material.dart';
import 'package:hasta_takip/screens/giris_yap/components/body.dart';
import '../../constants.dart';
import '../../size_config.dart';

class GirisEkrani extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(context),
      body: Body(),
    );
  }
}

AppBar _appBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    //elevation: 0,
    title: Text(
      "Giriş Yap",
      style: TextStyle(
          color: kPrimaryColor, fontSize: yuksekligeGoreAyarla(context, 27)),
    ),
  );
}
