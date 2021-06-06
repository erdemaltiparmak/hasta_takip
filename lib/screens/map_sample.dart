import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hasta_takip/models/current_user.dart';
import 'package:hasta_takip/screens/UI/statistics/turkiye.dart';
import 'package:hasta_takip/screens/splash_screen.dart';
import 'package:hasta_takip/services/current_user_service.dart';
import 'package:hasta_takip/utils/shared_preferences.dart';
import '../constants.dart';
import 'UI/profil/profil.dart';
import 'giris_yap/giris_ekrani.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

CurrentUserService currentUserService = CurrentUserService();
CurrentUser user;

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    globalCurrentUser =
        currentUserService.getPersonel(FirebaseAuth.instance.currentUser.email);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<PopUpMenuItems> menuItems = [
      PopUpMenuItems(
        Icons.logout,
        "Çıkış Yap",
        () {
          clearSharedPreferences();
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => GirisEkrani()),
                (Route<dynamic> route) => false);
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
          child: FutureBuilder(
              future: globalCurrentUser,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  );
                }
                user = snapshot.data;

                return Column(
                  children: [
                    ProfilHeader(menuItems: menuItems, user: snapshot.data),
                    GridView.count(
                      padding:
                          EdgeInsets.only(top: 11, left: 22.5, right: 22.5),
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      children: <Widget>[
                        anaSayfaButton(
                            icon: Icons.people,
                            text: "Hastalarım",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Profil(
                                            personelId: user.personelID,
                                          )));
                            }),
                        anaSayfaButton(
                            icon: Icons.bar_chart,
                            text: "İstatistikler",
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TurkiyeIstatistik()));
                            }),
                      ],
                    ),
                  ],
                );
              })),
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
    @required this.user,
  }) : super(key: key);

  final List<PopUpMenuItems> menuItems;
  final CurrentUser user;
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
                  user.personelAd + " " + user.personelSoyad,
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
