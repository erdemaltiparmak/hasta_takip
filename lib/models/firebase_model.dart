class FirebaseModel {
  int hastaID;
  String hastaAd;
  String hastaSoyad;
  int hastaYas;
  String hastaOyku;
  String hastaIletisimNo;
  String hastaAcikAdres;
  double hastaKonumX;
  double hastaKonumY;

  FirebaseModel(
      {this.hastaID,
      this.hastaAd,
      this.hastaSoyad,
      this.hastaYas,
      this.hastaOyku,
      this.hastaIletisimNo,
      this.hastaAcikAdres,
      this.hastaKonumX,
      this.hastaKonumY});

  FirebaseModel.fromJson(Map<String, dynamic> json) {
    hastaID = json['HastaID'];
    hastaAd = json['HastaAd'];
    hastaSoyad = json['HastaSoyad'];
    hastaYas = json['HastaYas'];
    hastaOyku = json['HastaOyku'];
    hastaIletisimNo = json['HastaIletisimNo'];
    hastaAcikAdres = json['HastaAcikAdres'];
    hastaKonumX = json['HastaKonumX'];
    hastaKonumY = json['HastaKonumY'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HastaID'] = this.hastaID;
    data['HastaAd'] = this.hastaAd;
    data['HastaSoyad'] = this.hastaSoyad;
    data['HastaYas'] = this.hastaYas;
    data['HastaOyku'] = this.hastaOyku;
    data['HastaIletisimNo'] = this.hastaIletisimNo;
    data['HastaAcikAdres'] = this.hastaAcikAdres;
    data['HastaKonumX'] = this.hastaKonumX;
    data['HastaKonumY'] = this.hastaKonumY;
    if (this.bileklik != null) {
      data['Bileklik'] = this.bileklik.toJson();
    }
    return data;
  }
}
