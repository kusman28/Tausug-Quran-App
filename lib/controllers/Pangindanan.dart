// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
class Bookmarks {
  int id;
  String ayat;

  Bookmarks(this.id, this.ayat);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'ayat': ayat,
    };
    return map;
  }

  Bookmarks.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    ayat = map['ayat'];
  }
}
