// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tausug_tafseer/models/Surah.dart';

class ServiceData {
  var mgaSurah = 'surah/surah.json';

  Future<List<Surah>> loadSurah() async {
    var response = await rootBundle.loadString(mgaSurah);
    Iterable data = json.decode(response);
    return data.map((model) => Surah.fromJson(model)).toList();
  }
}