import 'package:flutter/material.dart';
import 'package:hasta_takip/models/hasta.dart';
import 'package:hasta_takip/utils/distance_calculate.dart';

class UserBar extends StatelessWidget {
  const UserBar(
      {Key key,
      @required this.defaultImage,
      @required this.hasta,
      @required this.snapshot})
      : super(key: key);

  final ImageProvider<Object> defaultImage;
  final Hasta hasta;
  final AsyncSnapshot<dynamic> snapshot;
  @override
  Widget build(BuildContext context) {
    var distance = getDistanceFromLatLonInKm(
        snapshot.data.snapshot.value['konumX'],
        snapshot.data.snapshot.value['konumY'],
        hasta.hastaKonumX,
        hasta.hastaKonumY);

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
                          style: TextStyle(color: Colors.black, fontSize: 17),
                        ),
                        Text(
                          hasta.hastaYas.toString(),
                          style: TextStyle(color: Colors.black, fontSize: 16),
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
              distance < 50
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hasta Evinde :",
                          style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.5,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          distance.toStringAsFixed(2) + " m",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        )
                      ],
                    )
                  : Text(
                      "Hasta evinde değil!",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 21),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
