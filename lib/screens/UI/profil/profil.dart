import 'package:flutter/material.dart';
import 'package:hasta_takip/models/hasta.dart';
import 'package:hasta_takip/models/personel.dart';
import 'package:hasta_takip/screens/UI/hasta/hasata_detay.dart';
import 'package:hasta_takip/screens/giris_yap/giris_ekrani.dart';
import 'package:hasta_takip/services/covid_service.dart';
import 'package:hasta_takip/utils/shared_preferences.dart';
import '../../../constants.dart';

class Profil extends StatefulWidget {
  Profil({
    Key key,
  }) : super(key: key);

  @override
  _ProfilState createState() => _ProfilState();
}

Future<Personel> personel;
PersonelService personelService = PersonelService();
HastaService hastaService = HastaService();
bool isLoading = false;
var detailCache;
var detailCacheId;

class _ProfilState extends State<Profil> {
  @override
  void initState() {
    super.initState();

    personel = personelService.getPersonel();
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
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (c) => GirisEkrani()));
          });
        },
      )
    ];
    return Scaffold(
        appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
            title: Text("Hastalarım"),
            centerTitle: true,
            backgroundColor: Colors.green),
        backgroundColor: Colors.white.withOpacity(0.95),
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Stack(
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
                                          leading:
                                              Icon(e.icon, color: Colors.red),
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
                              "https://previews.123rf.com/images/yupiramos/yupiramos1607/yupiramos160705616/59613224-doctor-avatar-profile-isolated-icon-vector-illustration-graphic-.jpg"),
                          maxRadius: 50,
                          backgroundColor: Colors.white,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 115),
                        alignment: Alignment.center,
                        child: Text(
                          "Doç. Dr. Cüneyt Bayılmış",
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 12, right: 12, top: 12, bottom: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hastalarım",
                          style: TextStyle(
                              color: Colors.green.withGreen(150),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.arrow_drop_down_circle_outlined,
                          color: Colors.green,
                        )
                      ],
                    ),
                  ),
                  HastaListesi(),
                ],
              ),
            ),
            isLoading
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height,
                        width: double.infinity,
                        color: Colors.white.withOpacity(0.82),
                      ),
                      CircularProgressIndicator(color: Colors.green)
                    ],
                  )
                : Container()
          ],
        ));
  }

  Widget HastaListesi() {
    return Expanded(
      child: FutureBuilder(
        future: personel,
        builder: (context, AsyncSnapshot<Personel> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.hastas.length,
              itemBuilder: (context, index) {
                var hasta = snapshot.data.hastas[index];
                var hastaDetay = getHastaDetails(hasta.hastaID);
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      minVerticalPadding: 0,
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://lh3.googleusercontent.com/proxy/N4hrT7OxuhiyhNX3JBS-IoFs-9Ai_oPZ7MT-CUBRBNBiTMDNc2pZAEAvomEkfN2578w1Iccd9R9NryygFaqoqu46jaX5los0i4IvUryJMG8SGA"),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(hasta.hastaAd + " " + hasta.hastaSoyad),
                          Column(
                            children: [
                              Text(
                                karantinaHesapla(
                                            hasta.bileklik[0].takilmaTarihi)
                                        .toString() +
                                    "/10",
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () async {
                        setState(() {
                          isLoading = true;
                        });
                        if (detailCacheId == null) {
                          detailCache = await getHastaDetails(hasta.hastaID);
                          detailCacheId = index;
                        } else if (detailCacheId != index) {
                          detailCache = await getHastaDetails(hasta.hastaID);
                          detailCacheId = index;
                        }
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HastaDetay(
                                hasta: detailCache,
                              ),
                            ));
                      },
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: kPrimaryColor,
              ),
            );
          }
        },
      ),
    );
  }

  Future<Hasta> getHastaDetails(int hastaId) {
    var detail;
    detail = hastaService.getHasta(hastaId);
    return detail;
  }

  void popUpAction(Function() func) {
    func.call();
  }
}

int karantinaHesapla(String takilmaTarihi) {
  var bitisTarihi = DateTime.parse(takilmaTarihi);

  var fark = 10 - bitisTarihi.difference(DateTime.now()).inDays;
  return fark;
}
