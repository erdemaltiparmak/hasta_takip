import 'package:flutter/cupertino.dart';
import 'package:hasta_takip/models/hasta.dart';

class CacheData {
  int index;
  Hasta hasta;

  CacheData(this.index, this.hasta);
}

List<CacheData> caches;

class CacheList {
  List<CacheData> caches;

  void add(int index, Hasta hasta) {
    caches.add(new CacheData(index, hasta));
  }
}
