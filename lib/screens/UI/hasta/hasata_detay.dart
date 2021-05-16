import 'dart:async';
import 'dart:collection';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hasta_takip/models/hasta.dart';
import 'package:hasta_takip/size_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HastaDetay extends StatefulWidget {
  final Hasta hasta;
  const HastaDetay({Key key, @required this.hasta}) : super(key: key);

  @override
  _HastaDetayState createState() => _HastaDetayState(hasta);
}

class _HastaDetayState extends State<HastaDetay> {
  Completer<GoogleMapController> mapController = Completer();

  final LatLng _center = const LatLng(41.0235946, 28.7858438);
  final LatLng _person = const LatLng(41.0245946, 28.782938);

  BitmapDescriptor pinLocationIcon;
  BitmapDescriptor personLocationIcon;

  void _onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
  }

  void _onCameraMoveStarted() {}

  final referenceDatabase = FirebaseDatabase.instance;
  ImageProvider defaultImage;
  final Hasta hasta;
  var text = "";
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

  var selectedPin = 1;

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase
        .reference()
        .child("bileklik${hasta.bileklik.bileklikID}");
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        body: StreamBuilder(
          stream: ref.onValue,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            }
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
                          center: _center,
                          fillColor: Colors.greenAccent.withOpacity(.4))
                    },
                    markers: {
                      Marker(
                          markerId: MarkerId("ev"),
                          position: _center,
                          icon: pinLocationIcon,
                          onTap: () {
                            print(this._center.toString());
                          }),
                      Marker(
                        markerId: MarkerId("ev"),
                        position: _person,
                        icon: personLocationIcon,
                      )
                    },
                    padding: EdgeInsets.only(bottom: 22),
                    initialCameraPosition: CameraPosition(
                      target: _center,
                      zoom: 18.4,
                    ),
                  ),
                ),
                Positioned.fill(
                  top: 15,
                  left: 1,
                  right: 1,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        userbar(defaultImage: defaultImage, hasta: hasta),
                        // Container(
                        //     height: 200,
                        //     child: ListView(
                        //       scrollDirection: Axis.horizontal,
                        //       children: [
                        //         GrafikKart(context, snapshot,
                        //             path: 'nabiz', text: "Nabız"),
                        //         GrafikKart(context, snapshot,
                        //             path: 'oksijen', text: "Oksijen"),
                        //         GrafikKart(context, snapshot,
                        //             path: 'sicaklik', text: "Vücut Sıcaklığı"),
                        //       ],
                        //     ))
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
      ),
    );
  }

  Container GrafikKart(BuildContext context, AsyncSnapshot<dynamic> snapshot,
      {String text, String path}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          Text(snapshot.data.snapshot.value[path].toString()),
        ],
      ),
    );
  }
}

class HastaAyrinti extends StatelessWidget {
  const HastaAyrinti({
    Key key,
    Hasta hasta,
    AsyncSnapshot<dynamic> snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height * 1);
    print(MediaQuery.of(context).size.height * 0.025);
    print(MediaQuery.of(context).size.height * (1 - 0.025));

    return Positioned.fill(
        child: Container(
      padding: EdgeInsets.zero,
      child: DraggableScrollableSheet(
          expand: true,
          maxChildSize: 0.575,
          initialChildSize: 0.025,
          minChildSize: 0.025,
          builder: (context, controller) {
            return SingleChildScrollView(
              controller: controller,
              primary: false,
              child: Column(children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.025,
                  color: Colors.red,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: double.infinity,
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "data",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ]),
            );
          }),
    ));
  }
}

class sensorverileri extends StatelessWidget {
  const sensorverileri({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        child: Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.all(10),
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.8,
                  );
                })));
  }
}

class userbar extends StatelessWidget {
  const userbar({
    Key key,
    @required this.defaultImage,
    @required this.hasta,
  }) : super(key: key);

  final ImageProvider<Object> defaultImage;
  final Hasta hasta;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
          ),
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(image: defaultImage),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          hasta.hastaAd + " " + hasta.hastaSoyad,
                          style: TextStyle(color: Colors.green, fontSize: 17),
                        ),
                        Text(
                          hasta.hastaYas.toString(),
                          style: TextStyle(color: Colors.green, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.location_on,
                    color: Colors.green,
                    size: 36,
                  ),
                ],
              ),
              DateTime.parse(hasta.bileklik.takilmaTarihi)
                          .add(Duration(days: 10))
                          .difference(DateTime.now())
                          .inDays >
                      0
                  ? Text("Kalan Karantina Süresi:" +
                      DateTime.parse(hasta.bileklik.takilmaTarihi)
                          .add(Duration(days: 10))
                          .difference(DateTime.now())
                          .inDays
                          .toString() +
                      " Gün")
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
            // print(snapshot.data.snapshot.value.toString());
            // return Text(snapshot.data.snapshot.value.toString());
            // 
/*

Container(
              height: 200,
              child: Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      margin: EdgeInsets.all(10),
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.8,
                    );
                    ],
                  ),
                ),
              ],
            );
 */