import 'dart:io';

import 'package:hasta_takip/models/current_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var url = "https://bitirmecalismasiapi.azurewebsites.net/api";

class CurrentUserService {
  Future<CurrentUser> getPersonel(String who) async {
    CurrentUser currentUser;
    var data = await http.get(Uri.parse("$url/Personel/sorgula?eMail=$who"));
    // ignore: deprecated_member_use
    if (data.statusCode == HttpStatus.BAD_REQUEST) {
      print(data.body);
      throw new Exception();
    }
    var jsonData = jsonDecode(data.body);
    currentUser = CurrentUser.fromJson(jsonData);
    return currentUser;
  }
}
