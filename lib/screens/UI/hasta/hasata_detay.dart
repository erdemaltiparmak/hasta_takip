import 'dart:async';
import 'dart:ffi';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hasta_takip/models/hasta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'hasta_bar.dart';

class HastaDetay extends StatefulWidget {
  final Hasta hasta;
  const HastaDetay({Key key, @required this.hasta}) : super(key: key);
  @override
  _HastaDetayState createState() => _HastaDetayState(hasta);
}

GoogleMapController googleMapController;

class _HastaDetayState extends State<HastaDetay> {
  final Hasta hasta;
  final referenceDatabase = FirebaseDatabase.instance;

  Completer<GoogleMapController> mapController = Completer();
  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor personLocationIcon;
  ImageProvider defaultImage;

  void _onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
    googleMapController = controller;
  }

  LatLng hastaKonum;

  void _onCameraMoveStarted() {}

  _HastaDetayState(this.hasta);
  @override
  void initState() {
    defaultImage = NetworkImage(
        "https://icon-library.com/images/white-profile-icon/white-profile-icon-24.jpg");
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(32, 32)),
            'assets/images/homeicon.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(32, 32)),
            'assets/images/personicon.png')
        .then((onValue) {
      personLocationIcon = onValue;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase
        .reference()
        .child("bileklik${hasta.bileklik.bileklikID}");
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: StreamBuilder(
        stream: ref.onValue,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          hastaKonum = LatLng(snapshot.data.snapshot.value['konumX'],
              snapshot.data.snapshot.value['konumY']);
          return Stack(
            children: [
              Positioned.fill(
                child: GoogleMap(
                  onCameraMoveStarted: _onCameraMoveStarted,
                  onMapCreated: _onMapCreated,
                  circles: {
                    Circle(
                        circleId: CircleId("evCircle"),
                        strokeWidth: 1,
                        radius: 20,
                        center: hastaKonum,
                        fillColor: Colors.greenAccent.withOpacity(.4))
                  },
                  markers: {
                    Marker(
                        markerId: MarkerId("hasta"),
                        position: hastaKonum,
                        icon: personLocationIcon),
                    Marker(
                      markerId: MarkerId("ev"),
                      position: LatLng(hasta.hastaKonumX, hasta.hastaKonumY),
                      icon: pinLocationIcon,
                    )
                  },
                  padding: EdgeInsets.only(bottom: 22),
                  initialCameraPosition: CameraPosition(
                    target: LatLng(snapshot.data.snapshot.value['konumX'],
                        snapshot.data.snapshot.value['konumY']),
                    zoom: 18.4,
                  ),
                ),
              ),
              Positioned.fill(
                top: 30,
                left: 1,
                right: 1,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      UserBar(
                          defaultImage: defaultImage,
                          hasta: hasta,
                          snapshot: snapshot),
                      Container(
                        padding: EdgeInsets.only(top: 8),
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GrafikKart(context, snapshot,
                                path: 'nabiz', text: "Nab??z"),
                            GrafikKart(context, snapshot,
                                path: 'oksijen', text: "SpO2"),
                            GrafikKart(context, snapshot,
                                path: 'sicaklik', text: "Ate??"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              HastaAyrinti(
                hasta: hasta,
                snapshot: snapshot,
              )
            ],
          );
        },
      ),
    );
  }

  Widget GrafikKart(BuildContext context, AsyncSnapshot<dynamic> snapshot,
      {String text, String path}) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width / 3.3,
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
          blurRadius: 2,
          color: Colors.green,
        )
      ], borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text + ": ",
            style: TextStyle(color: Colors.black, fontSize: 19),
          ),
          Text(
            snapshot.data.snapshot.value[path].toString(),
            style: TextStyle(color: Colors.black, fontSize: 19),
          ),
        ],
      ),
    );
  }
}

class HastaAyrinti extends StatelessWidget {
  const HastaAyrinti({
    Key key,
    this.hasta,
    this.snapshot,
  }) : super(key: key);
  final Hasta hasta;
  final AsyncSnapshot<dynamic> snapshot;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        bottom: 0,
        child: Container(
          child: DraggableScrollableSheet(
              expand: true,
              maxChildSize: 0.575,
              initialChildSize: 0.025,
              minChildSize: 0.025,
              builder: (context, controller) {
                return SingleChildScrollView(
                  controller: controller,
                  child: Column(children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.025,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 55,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height * 0.550,
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Hasta Bilgileri",
                                style: TextStyle(
                                    color: Colors.green.withGreen(140),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24),
                              )
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 14, top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MouseRegion(
                                  onHover: (v) {
                                    print(v.toString());
                                  },
                                  child: HastaBilgileriText(
                                    text: "Hasta Ad??",
                                    bilgi: hasta.hastaAd +
                                        " " +
                                        hasta.hastaSoyad +
                                        " (${hasta.hastaYas})",
                                  ),
                                ),
                                HastaBilgileriText(
                                  text: "Hasta ??yk??s??",
                                  bilgi: hasta.hastaOyku,
                                ),
                                HastaBilgileriText(
                                  text: "Hasta ??leti??im No",
                                  bilgi: hasta.hastaIletisimNo,
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              hastaBilgileriButton(
                                  toolTip:
                                      "Hastay?? Ara\n${hasta.hastaIletisimNo}",
                                  icon: Icons.call_outlined,
                                  onPressed: () {
                                    _launchCaller(
                                        "tel:${hasta.hastaIletisimNo}");
                                  }),
                              hastaBilgileriButton(
                                  icon: Icons.mail_outlined,
                                  onPressed: () {
                                    _launchCaller(
                                        "sms:${hasta.hastaIletisimNo}");
                                  }),
                              hastaBilgileriButton(
                                  color: Colors.red,
                                  icon: Icons.ac_unit,
                                  onPressed: () {
                                    _launchCaller("tel:112");
                                  },
                                  text: "112"),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ]),
                );
              }),
        ));
  }

  Widget hastaBilgileriButton(
      {@required Object icon,
      @required Function onPressed,
      String text = "",
      String toolTip = "",
      Color color = Colors.green}) {
    return MouseRegion(
      onHover: (v) {
        print(v.toString());
      },
      child: Container(
        width: 70,
        height: 70,
        margin: EdgeInsets.only(left: 10),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
        child: Tooltip(
          message: toolTip,
          child: MaterialButton(
            child: text == ""
                ? Icon(
                    icon,
                    color: Colors.white,
                    size: 34,
                  )
                : Text(text,
                    style: TextStyle(color: Colors.white, fontSize: 22.2)),
            splashColor: Colors.black,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}

class HastaBilgileriText extends StatelessWidget {
  const HastaBilgileriText({Key key, @required this.bilgi, @required this.text})
      : super(key: key);

  final String bilgi, text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(
              bottom: 2, // Space between underline and text
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.green,
              width: 2.0, // Underline thickness
            ))),
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: Colors.green.withGreen(100),
              ),
            ),
          ),
          Text(bilgi,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 17)),
        ],
      ),
    );
  }
}

_launchCaller(String url) async {
  try {
    await launch(url);
  } catch (e) {
    print(e.toString());
  }
}
