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
import 'package:testing/app/data/models/DetailJuz.dart';
import 'package:testing/app/data/models/DetailSurah.dart';
import 'dart:convert';

import 'package:testing/app/data/models/Surah.dart';

void main() async {
  Future<DetailJuz> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/juz/$id");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

    var dataInstance = DetailJuz.fromJson(data);
    print('${dataInstance.juzStartInfo}');
    return DetailJuz.fromJson(data);
  }

  await getDetailSurah(1.toString());

  // Future<Juz> getDetailJuz(String id) async {
  //   Uri url = Uri.parse("https://api.quran.gading.dev/juz/$id");
  //   var res = await http.get(url);

  //   Map<String, dynamic> data =
  //       (json.decode(res.body) as Map<String, dynamic>)["data"];
  //   return Juz.fromJson(data);
  // }

  // await getDetailJuz(1.toString());
  /**Uri url = Uri.parse("https://api.quran.gading.dev/surah");
  var res = await http.get(url);
  List data = (json.decode(res.body) as Map<String, dynamic>)["data"];
  Surah surahAnnas = Surah.fromJson(data[113]);


 
 */

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

  // Uri urlDSurah = Uri.parse("https://api.quran.gading.dev/surah/108");
  // var resDsurah = await http.get(urlDSurah);
  // Map<String, dynamic> dataDsurah =
  //     (json.decode(resDsurah.body) as Map<String, dynamic>)["data"];
  // DetailAyat ayat = DetailAyat.fromJson(dataDsurah);
  // print(ayat.surah);\

  // Uri urlAnnas = Uri.parse("https://api.quran.gading.dev/surah/3}");
  // var resAnnas = await http.get(urlAnnas);
  // Map<String, dynamic> daataAnnas =
  //     (json.decode(resAnnas.body) as Map<String, dynamic>)["data"];
  // /**Mengubah  dari data api (raw data/jsonData) menjadi Model Data**/
  // DetailSurah annas = DetailSurah.fromJson(daataAnnas);
  // print(annas.name);

//   Uri url = Uri.parse("https://api.quran.gading.dev/juz/8");
//   var res = await http.get(url);
//   Map<String, dynamic> data =
//       (json.decode(res.body) as Map<String, dynamic>)["data"];
//   Juz datajuz = Juz.fromJson(data);
//   print(datajuz.data);
}
