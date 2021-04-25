// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tausug_tafseer/models/MasajidModel.dart';

class Service {
  var mgaMasjid = 'data/masajid.json';

  Future<List<MgaMasjid>> loadMasajid() async {
    var response = await rootBundle.loadString(mgaMasjid);
    Iterable data = json.decode(response);
    return data.map((model) => MgaMasjid.fromJson(model)).toList();
  }
}
