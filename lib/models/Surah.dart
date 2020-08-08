// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'dart:convert';

List<Surah> surahFromJson(String str) => List<Surah>.from(json.decode(str).map((x) => Surah.fromJson(x)));

String surahToJson(List<Surah> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Surah {
    String translation;
    String arabic;
    String latin;
    String image;
    int ayahCount;
    int index;
    String opening;
    String closing;

    Surah({
        this.translation,
        this.arabic,
        this.latin,
        this.image,
        this.ayahCount,
        this.index,
        this.opening,
        this.closing,
    });

    factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        translation: json["translation"] == null ? null : json["translation"],
        arabic: json["arabic"] == null ? null : json["arabic"],
        latin: json["latin"] == null ? null : json["latin"],
        image: json["image"] == null ? null : json["image"],
        ayahCount: json["ayah_count"] == null ? null : json["ayah_count"],
        index: json["index"] == null ? null : json["index"],
        opening: json["opening"] == null ? null : json["opening"],
        closing: json["closing"] == null ? null : json["closing"],
    );

    Map<String, dynamic> toJson() => {
        "translation": translation == null ? null : translation,
        "arabic": arabic == null ? null : arabic,
        "latin": latin == null ? null : latin,
        "image": image == null ? null : image,
        "ayah_count": ayahCount == null ? null : ayahCount,
        "index": index == null ? null : index,
        "opening": opening == null ? null : opening,
        "closing": closing == null ? null : closing,
    };
}
