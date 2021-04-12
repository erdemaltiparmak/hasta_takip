import 'package:flutter/material.dart';
import 'package:hasta_takip/size_config.dart';

import '../../../constants.dart';

class Profil extends StatefulWidget {
  Profil({Key key}) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

List<PopUpMenuItems> menuItems = [
  PopUpMenuItems(Icons.logout, "Çıkış Yap", () => clearSharedPreferences())
];

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.only(top: 20),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, left: 10, right: 10),
              height: 200,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: Colors.grey.shade300),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Ecem Altıparmak",
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Muli',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15, top: 25),
              alignment: Alignment.topRight,
              child: PopupMenuButton(
                  onSelected: popUpAction,
                  child: Icon(
                    Icons.settings,
                    color: Colors.green,
                    size: 28,
                  ),
                  tooltip: "Ayarlar",
                  itemBuilder: (context) {
                    return menuItems
                        .map((e) => PopupMenuItem(
                              child: ListTile(
                                isThreeLine: false,
                                contentPadding: EdgeInsets.all(0),
                                title: Text(e.text,
                                    style: TextStyle(
                                      fontSize: 18,
                                    )),
                                leading: Icon(e.icon, color: Colors.red),
                              ),
                              value: e.func,
                            ))
                        .toList();
                  }),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://eslteacherginny.com/wp-content/uploads/2019/12/fem-avtr.png"),
                maxRadius: 50,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  void popUpAction(Function() func) {
    func.call();
  }
}
