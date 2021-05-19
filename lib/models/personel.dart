class Personel {
  int personelID;
  String personelAd;
  String personelSoyad;
  String personelMail;
  List<Hastas> hastas;

  Personel(
      {this.personelID,
      this.personelAd,
      this.personelSoyad,
      this.personelMail,
      this.hastas});

  Personel.fromJson(Map<String, dynamic> json) {
    personelID = json['personelID'];
    personelAd = json['personelAd'];
    personelSoyad = json['personelSoyad'];
    personelMail = json['personelMail'];
    if (json['hastas'] != null) {
      hastas = new List<Hastas>();
      json['hastas'].forEach((v) {
        hastas.add(new Hastas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['personelID'] = this.personelID;
    data['personelAd'] = this.personelAd;
    data['personelSoyad'] = this.personelSoyad;
    data['personelMail'] = this.personelMail;
    if (this.hastas != null) {
      data['hastas'] = this.hastas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hastas {
  int hastaID;
  String hastaAd;
  String hastaSoyad;
  int hastaYas;
  List<Bileklik> bileklik;

  Hastas(
      {this.hastaID,
      this.hastaAd,
      this.hastaSoyad,
      this.hastaYas,
      this.bileklik});

  Hastas.fromJson(Map<String, dynamic> json) {
    hastaID = json['hastaID'];
    hastaAd = json['hastaAd'];
    hastaSoyad = json['hastaSoyad'];
    hastaYas = json['hastaYas'];
    if (json['bileklik'] != null) {
      bileklik = new List<Bileklik>();
      json['bileklik'].forEach((v) {
        bileklik.add(new Bileklik.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hastaID'] = this.hastaID;
    data['hastaAd'] = this.hastaAd;
    data['hastaSoyad'] = this.hastaSoyad;
    data['hastaYas'] = this.hastaYas;
    if (this.bileklik != null) {
      data['bileklik'] = this.bileklik.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Bileklik {
  int bileklikID;
  String takilmaTarihi;

  Bileklik({this.bileklikID, this.takilmaTarihi});

  Bileklik.fromJson(Map<String, dynamic> json) {
    bileklikID = json['bileklikID'];
    takilmaTarihi = json['takilmaTarihi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bileklikID'] = this.bileklikID;
    data['takilmaTarihi'] = this.takilmaTarihi;
    return data;
  }
}
