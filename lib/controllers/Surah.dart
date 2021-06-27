// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:tausug_tafseer/models/Surah.dart';
import 'package:tausug_tafseer/models/SurahTafseer.dart';

import '../main.dart';

class ServiceData {
  var mgaSurah = 'surah/surah.json';

  Future<List<Surah>> loadSurah() async {
    var response = await rootBundle.loadString(mgaSurah);
    Iterable data = json.decode(response);
    return data.map((model) => Surah.fromJson(model)).toList();
  }

  Future<AllSurah> loadSurahTafseer(int number) async {
    final response = await rootBundle.loadString('surah/$number.json');
    var res = json.decode(response);
    var data = res['$number'];
    return AllSurah.fromJson(data);
  }

  // Future getSurahTafsir(int number) async {
  //   final surahs = Hive.box(API_BOX).get('surahs', defaultValue: []);
  //   if (surahs.isNotEmpty) return surahs;
  //   // final http.Response res =
  //   //     await http.get('https://jsonplaceholder.typicode.com/posts');
  //   final res = await rootBundle.loadString('surah/$number.json');
  //   final resjson = json.decode(res);
  //   var data = resjson['$number'];
  //   Hive.box(API_BOX).put("surahs", data);
  //   return AllSurah.fromJson(data);
  // }
}
