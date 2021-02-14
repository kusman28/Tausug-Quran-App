import 'package:floor/floor.dart';

@entity
class Favorite {
  @primaryKey
  final int id;
  final String uid, ayat, tafsir;

  Favorite(this.id, this.uid, this.ayat, this.tafsir);
}
