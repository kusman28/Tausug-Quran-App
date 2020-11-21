// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';

class Pangindanan {
  int id;
  String ayat;

  Pangindanan({this.id, this.ayat});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'ayat': ayat,
    };
    return map;
  }

  Pangindanan.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    ayat = map['ayat'];
  }
}
// class SharedPref {
//   read(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     return json.decode(prefs.getString(key));
//   }

//   save(String key, value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(key, json.encode(value));
//   }

//   remove(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove(key);
//   }
// }
