// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:testing/app/data/models/DetailAyat.dart';
import 'package:testing/app/data/models/DetailSurah.dart';
import 'dart:convert';

import 'package:testing/app/data/models/Surah.dart';

void main() async {
  /**Uri url = Uri.parse("https://api.quran.gading.dev/surah");
  var res = await http.get(url);
  List data = (json.decode(res.body) as Map<String, dynamic>)["data"];
  Surah surahAnnas = Surah.fromJson(data[113]);

  Uri urlAnnas =
      Uri.parse("https://api.quran.gading.dev/surah/${surahAnnas.number}");
  var resAnnas = await http.get(urlAnnas);
  Map<String, dynamic> daataAnnas =
      (json.decode(resAnnas.body) as Map<String, dynamic>)["data"];
  /**Mengubah  dari data api (raw data/jsonData) menjadi Model Data**/
  DetailSurah annas = DetailSurah.fromJson(daataAnnas);
  print(annas.verses?[0].text?.transliteration.en);
 
 */

  Uri url = Uri.parse("https://api.quran.gading.dev/surah/108/1");
  var res = await http.get(url);
  Map<String, dynamic> dataAyat = json.decode(res.body)["data"];
  //optional
  // Map<String, dynamic> dataToModel = {
  //   "number": dataAyat["number"],
  //   "meta": dataAyat["meta"],
  //   "text": dataAyat["text"],
  //   "translation": dataAyat["translation"],
  //   "audio": dataAyat["audio"],
  //   "tafsir": dataAyat["tafsir"]
  // };

  //convert mapping ke model ayat
  DetailAyat ayat = DetailAyat.fromJson(dataAyat);
  print(ayat.tafsir.id.short);
}
