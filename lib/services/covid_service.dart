import 'dart:io';

import 'package:hasta_takip/models/hasta.dart';
import 'package:hasta_takip/models/personel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/country_summary.dart';

class CovidService {
  Future<List<CountrySummaryModel>> getTurkeyStatistics() async {
    final data = await http.Client().get(
        Uri.parse("https://api.covid19api.com/total/dayone/country/turkey"));

    if (data.statusCode != 200) throw Exception();

    List<CountrySummaryModel> summaryList = (json.decode(data.body) as List)
        .map((item) => new CountrySummaryModel.fromJson(item))
        .toList();

    return summaryList;
  }
}

var url = "https://bitirmecalismasiapi20210606183051.azurewebsites.net/api";

class PersonelService {
  Future<Personel> getPersonel(int id) async {
    Personel personel;
    var data = await http.get(Uri.parse("$url/personel/$id"));
    // ignore: deprecated_member_use
    if (data.statusCode == HttpStatus.BAD_REQUEST) {
      print(data.body);
      throw new Exception();
    }
    var jsonData = jsonDecode(data.body);
    personel = Personel.fromJson(jsonData);
    return personel;
  }
}

class HastaService {
  Future<Hasta> getHasta(int hastaId) async {
    Hasta hasta;
    var data = await http.get(Uri.parse("$url/hasta/$hastaId"));
    // ignore: deprecated_member_use
    if (data.statusCode == HttpStatus.BAD_REQUEST) {
      print(data.body);
      throw new Exception();
    }
    var jsonData = jsonDecode(data.body);
    hasta = Hasta.fromJson(jsonData);
    return hasta;
  }
}
