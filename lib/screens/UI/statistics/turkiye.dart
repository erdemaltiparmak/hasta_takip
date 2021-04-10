import 'package:flutter/material.dart';

class TurkiyeIstatistik extends StatefulWidget {
  @override
  _TurkiyeIstatistikState createState() => _TurkiyeIstatistikState();
}

class _TurkiyeIstatistikState extends State<TurkiyeIstatistik> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [Text("data"), Text("data")],
            ),
          )
        ],
      ),
    );
  }
}
