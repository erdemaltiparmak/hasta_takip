import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hasta_takip/constants.dart';
import 'package:hasta_takip/screens/UI/profil/profil.dart';
import 'package:hasta_takip/screens/UI/statistics/turkiye.dart';
import 'package:hasta_takip/screens/map_sample.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

List<Screens> screenList = [
  Screens("Ana Sayfa", Container()),
  Screens("İstatistikler", TurkiyeIstatistik()),
  Screens("Container", MapSample()),
  Screens("Profil", Profil()),
];

class _MainPageState extends State<MainPage> {
  int _currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(screenList[_currentIndex].title),
        centerTitle: true,
      ),
      body: screenList[_currentIndex].screen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() {
          _currentIndex = index;
        }),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        showSelectedLabels: true,
        selectedLabelStyle: TextStyle(color: Colors.white),
        selectedIconTheme: IconThemeData(size: 28),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white.withOpacity(0.45),
        elevation: 0.0,
        items: [Icons.home, Icons.insert_chart, Icons.event_note, Icons.info]
            .asMap()
            .map((key, value) => MapEntry(
                  key,
                  BottomNavigationBarItem(
                      label: screenList[key].title, icon: Icon(value)),
                ))
            .values
            .toList(),
      ),
    );
  }
}

final LatLng _center = const LatLng(45.521563, -122.677433);

void _onMapCreated(GoogleMapController controller) {}
