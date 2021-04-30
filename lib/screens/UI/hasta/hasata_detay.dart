import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hasta_takip/models/hasta.dart';
import 'package:hasta_takip/size_config.dart';

class HastaDetay extends StatefulWidget {
  final Hasta hasta;
  const HastaDetay({Key key, @required this.hasta}) : super(key: key);

  @override
  _HastaDetayState createState() => _HastaDetayState(hasta);
}

class _HastaDetayState extends State<HastaDetay> {
  final referenceDatabase = FirebaseDatabase.instance;
  ImageProvider defaultImage;
  final Hasta hasta;
  var text = "";
  _HastaDetayState(this.hasta);
  @override
  void initState() {
    defaultImage = NetworkImage(
        "https://icon-library.com/images/white-profile-icon/white-profile-icon-24.jpg");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ref = referenceDatabase
        .reference()
        .child("bileklik${hasta.bileklik.bileklikID}");
    return Scaffold(
      backgroundColor: Colors.green,
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
              Positioned(
                top: 30,
                left: 1,
                right: 1,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      userbar(defaultImage: defaultImage, hasta: hasta),
                      Container(
                          height: 200,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                margin: EdgeInsets.all(10),
                                height: 200,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Nabız"),
                                    Text(snapshot.data.snapshot.value['nabiz']
                                        .toString()),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                margin: EdgeInsets.all(10),
                                height: 200,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Oksijen SpO2"),
                                    Text(snapshot.data.snapshot.value['oksijen']
                                        .toString()),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20)),
                                margin: EdgeInsets.all(10),
                                height: 200,
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Vücut Sıcaklığı",
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    Text(
                                      snapshot.data.snapshot.value['sicaklik']
                                          .toString(),
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                          //ListView.builder(
                          //     shrinkWrap: true,
                          //     scrollDirection: Axis.horizontal,
                          //     itemCount: 3,
                          //     itemBuilder: (BuildContext context, int index) {
                          //       return Container(
                          //         decoration: BoxDecoration(
                          //             color: Colors.white,
                          //             borderRadius: BorderRadius.circular(20)),
                          //         margin: EdgeInsets.all(10),
                          //         height:L 200,
                          //         width: MediaQuery.of(context).size.width * 0.8,
                          //         child: Text(snapshot
                          //             .data.snapshot.value['nabiz']
                          //             .toString()),
                          //       );
                          //     }),
                          )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
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