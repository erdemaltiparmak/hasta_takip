import 'package:flutter/material.dart';
import 'package:hasta_takip/constants.dart';

class NavigationOption extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() onSelected;
  final IconData icon;

  NavigationOption(
      {Key key,
      @required this.icon,
      @required this.title,
      @required this.isSelected,
      @required this.onSelected})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isSelected
              ? Column(
                  children: [],
                )
              : Container(),
          Icon(icon),
          Text(
            title,
            style: TextStyle(
                color: isSelected ? kPrimaryColor : Colors.grey,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
