// بسم الله الرحمن الرحيم
// O' Tuhan namu papag-barakata kamu in Application ini
// sarta tarbilanga kami dayng ha mga Mukhliseen. Ameen
import 'package:flutter/material.dart';

class UI with ChangeNotifier {
  static double ayatSize = 0.7;
  static double tafseerSize = 0.4;
  static bool translate = true;
  static bool makna = false;

  set fontSize(newValue) {
    ayatSize = newValue;
    notifyListeners();
  }
  double get fontSize => ayatSize * 35;
  double get sliderFontSize => ayatSize;
  

  set fontSizetext(newValue) {
    tafseerSize = newValue;
    notifyListeners();
  }
  double get fontSizetext => tafseerSize * 40;
  double get sliderFontSizetext => tafseerSize;

  set tarjuma(newValue) {
    translate = newValue;
    notifyListeners();
  }
  bool get tarjuma => translate;

  set tafseer(newValue){
    makna = newValue;
    notifyListeners();
  }
  bool get tafseer => makna;
}