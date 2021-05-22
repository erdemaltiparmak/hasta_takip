class CurrentUser {
  int personelID;
  String personelAd;
  String personelSoyad;
  String personelMail;
  Null hastas;

  CurrentUser(
      {this.personelID,
      this.personelAd,
      this.personelSoyad,
      this.personelMail,
      this.hastas});

  CurrentUser.fromJson(Map<String, dynamic> json) {
    personelID = json['personelID'];
    personelAd = json['personelAd'];
    personelSoyad = json['personelSoyad'];
    personelMail = json['personelMail'];
    hastas = json['hastas'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personelID'] = this.personelID;
    data['personelAd'] = this.personelAd;
    data['personelSoyad'] = this.personelSoyad;
    data['personelMail'] = this.personelMail;
    data['hastas'] = this.hastas;
    return data;
  }
}

Future<CurrentUser> globalCurrentUser;
