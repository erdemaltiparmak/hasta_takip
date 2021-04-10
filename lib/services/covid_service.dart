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
