import 'package:flutter/material.dart';
import 'package:hasta_takip/models/country_summary.dart';
import 'package:hasta_takip/size_config.dart';

class TurkeyCards extends StatelessWidget {
  const TurkeyCards({Key key, @required this.turkeySummary}) : super(key: key);

  final List<CountrySummaryModel> turkeySummary;

  @override
  Widget build(BuildContext context) {
    int today = turkeySummary.length - 1;

    return Column(
      children: [
        buildCard(
            context: context,
            leftTitle: "Bugün",
            leftValue: turkeySummary[today].confirmed -
                turkeySummary[today - 1].confirmed,
            leftColor: Colors.green,
            rightValue:
                turkeySummary[today].death - turkeySummary[today - 1].death),
        buildCard(
            context: context,
            leftTitle: "Toplam",
            leftValue: turkeySummary[turkeySummary.length - 1].confirmed,
            leftColor: Colors.green,
            rightValue: turkeySummary[turkeySummary.length - 1].death),
      ],
    );
  }
}

Widget buildCard(
    {BuildContext context,
    String leftTitle,
    Color leftColor,
    int leftValue,
    String rightTitle,
    Color rightColor,
    int rightValue}) {
  return Card(
    color: Color(0xff6F6F6F), // Color.fromRGBO(184, 230, 57, 1),
    elevation: 1,
    child: Column(
      children: [
        Container(
          color: Color(0xff00A0A0),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                leftTitle,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ],
          ),
        ),
        Container(
          height: yuksekligeGoreAyarla(context, 70),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: Container()),
                  Text(
                    "Vaka Sayısı",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  Text(
                    leftValue.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(child: Container()),
                  Text(
                    "Vefat Sayısı",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  Text(
                    rightValue.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    ),
  );
}
