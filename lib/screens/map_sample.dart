import 'package:flutter/material.dart';
import 'package:hasta_takip/screens/UI/statistics/turkiye.dart';
import 'package:hasta_takip/utils/shared_preferences.dart';
import '../constants.dart';
import 'UI/profil/profil.dart';
import 'giris_yap/giris_ekrani.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  Widget build(BuildContext context) {
    List<PopUpMenuItems> menuItems = [
      PopUpMenuItems(
        Icons.logout,
        "Çıkış Yap",
        () {
          clearSharedPreferences();
          Future.delayed(Duration(seconds: 1), () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (c) => GirisEkrani()));
          });
        },
      )
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: Text(
          "Hasta Takip Sistemi",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            ProfilHeader(menuItems: menuItems),
            GridView.count(
              padding: EdgeInsets.only(top: 11, left: 22.5, right: 22.5),
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              shrinkWrap: true,
              crossAxisCount: 2,
              children: <Widget>[
                anaSayfaButton(
                    icon: Icons.people,
                    text: "Hastalarım",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Profil()));
                    }),
                anaSayfaButton(
                    icon: Icons.people,
                    text: "İstatistikler",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TurkiyeIstatistik()));
                    }),
                anaSayfaButton(
                    icon: Icons.people, text: "Hastalarım", onPressed: () {}),
                anaSayfaButton(
                    icon: Icons.people, text: "Hastalarım", onPressed: () {}),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Container anaSayfaButton({String text, IconData icon, Function onPressed}) {
  return Container(
    decoration: BoxDecoration(
        color: Colors.green, borderRadius: BorderRadius.circular(15)),
    child: MaterialButton(
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 59,
          ),
          SizedBox(
            height: 10,
          ),
          Text(text, style: TextStyle(color: Colors.white, fontSize: 22))
        ],
      ),
    ),
  );
}

class ProfilHeader extends StatelessWidget {
  const ProfilHeader({
    Key key,
    @required this.menuItems,
  }) : super(key: key);

  final List<PopUpMenuItems> menuItems;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
          height: 140,
          width: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              color: Colors.grey.shade300),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [],
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
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://previews.123rf.com/images/yupiramos/yupiramos1607/yupiramos160705616/59613224-doctor-avatar-profile-isolated-icon-vector-illustration-graphic-.jpg"),
                maxRadius: 50,
                backgroundColor: Colors.white,
              ),
              Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.center,
                child: Text(
                  "Doç. Dr. Cüneyt Bayılmış",
                  style: TextStyle(color: Colors.black, fontSize: 17),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

void popUpAction(Function() func) {
  func.call();
}
