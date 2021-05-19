import 'package:flutter/material.dart';
import 'package:hasta_takip/models/country_summary.dart';
import 'package:hasta_takip/screens/UI/statistics/turkey_cards.dart';
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
    super.initState();
    summary = covidService.getTurkeyStatistics();
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text("İstatistikler"),
          centerTitle: true,
          backgroundColor: Colors.green),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
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
                          fontSize: 19),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          summary = covidService.getTurkeyStatistics();
                        });
                      },
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
                ),
                FutureBuilder(
                  future: summary,
                  builder: (context, snapshot) {
                    if (snapshot.hasError)
                      return Center(
                        child: Text("Hata"),
                      );
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(child: LinearProgressIndicator());
                      default:
                        return !snapshot.hasData
                            ? Center(
                                child: Text("Veri Yok"),
                              )
                            : TurkeyCards(
                                turkeySummary: snapshot.data,
                              );
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
