class Hasta {
  int hastaID;
  String hastaAd;
  String hastaSoyad;
  int hastaYas;
  String hastaOyku;
  String hastaIletisimNo;
  String hastaAcikAdres;
  double hastaKonumX;
  double hastaKonumY;
  Bileklik bileklik;

  Hasta(
      {this.hastaID,
      this.hastaAd,
      this.hastaSoyad,
      this.hastaYas,
      this.hastaOyku,
      this.hastaIletisimNo,
      this.hastaAcikAdres,
      this.hastaKonumX,
      this.hastaKonumY,
      this.bileklik});

  Hasta.fromJson(Map<String, dynamic> json) {
    hastaID = json['HastaID'];
    hastaAd = json['HastaAd'];
    hastaSoyad = json['HastaSoyad'];
    hastaYas = json['HastaYas'];
    hastaOyku = json['HastaOyku'];
    hastaIletisimNo = json['HastaIletisimNo'];
    hastaAcikAdres = json['HastaAcikAdres'];
    hastaKonumX = json['HastaKonumX'];
    hastaKonumY = json['HastaKonumY'];
    bileklik = json['Bileklik'] != null
        ? new Bileklik.fromJson(json['Bileklik'])
        : null;
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

class Bileklik {
  int bileklikID;
  String takilmaTarihi;

  Bileklik({this.bileklikID, this.takilmaTarihi});

  Bileklik.fromJson(Map<String, dynamic> json) {
    bileklikID = json['BileklikID'];
    takilmaTarihi = json['TakilmaTarihi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BileklikID'] = this.bileklikID;
    data['TakilmaTarihi'] = this.takilmaTarihi;
    return data;
  }
}
