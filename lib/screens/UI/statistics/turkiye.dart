import 'package:flutter/material.dart';
import 'package:hasta_takip/models/country_summary.dart';
import 'package:hasta_takip/services/covid_service.dart';

CovidService covidService = CovidService();

class TurkiyeIstatistik extends StatefulWidget {
  @override
  _TurkiyeIstatistikState createState() => _TurkiyeIstatistikState();
}

class _TurkiyeIstatistikState extends State<TurkiyeIstatistik> {
  Future<List<CountrySummaryModel>> summary;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    summary = covidService.getTurkeyStatistics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Güncel Türkiye Vaka Sayıları",
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    GestureDetector(
                      onTap: null,
                      child: Icon(
                        Icons.refresh,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
                Divider(
                  color: Colors.green.shade600,
                  // thickness: 0.8,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
