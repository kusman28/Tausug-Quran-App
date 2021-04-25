// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'dart:convert';

List<MgaMasjid> masajidFromJson(String str) =>
    List<MgaMasjid>.from(json.decode(str).map((x) => MgaMasjid.fromJson(x)));

String masajidToJson(List<MgaMasjid> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MgaMasjid {
  MgaMasjid({
    this.id,
    this.city,
    this.location,
    this.masjid,
    this.lat,
    this.long,
  });

  int id;
  String city;
  String location;
  String masjid;
  double lat;
  double long;

  factory MgaMasjid.fromJson(Map<String, dynamic> json) => MgaMasjid(
        id: json["id"],
        city: json["city"],
        location: json["location"],
        masjid: json["masjid"],
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "city": city,
        "location": location,
        "masjid": masjid,
        "lat": lat,
        "long": long,
      };
}
