import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final Function onPressed;
  final Color buttonColor;
  final Color fontColor;
  final double fontSize;
  final String title;

  const Button(
      {Key key,
      @required this.onPressed,
      this.buttonColor,
      this.fontColor,
      this.title,
      this.fontSize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      onPressed: onPressed,
      color: buttonColor ?? Colors.lightBlue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 4.0,
          ),
          Text(
            title,
            style:
                TextStyle(color: fontColor ?? Colors.white, fontSize: fontSize),
          ),
        ],
      ),
    );
  }
}
