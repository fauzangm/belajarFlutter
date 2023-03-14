// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/app/data/models/DetailSurah.dart';
import 'package:untitled/app/data/models/Surah.dart';
import 'package:untitled/main.dart';
import 'dart:convert';
void main()async{
  Uri url = Uri.parse("https://api.quran.gading.dev/surah");
  var res  = await http.get(url);
  // print(res.body);
  List data = (json.decode(res.body) as Map<String,dynamic>)["data"];
  // print(data[113]["number"]);
  Surah surahAnnas = Surah.fromJson(data[113]);
  // print(surahAnnas.name);
  // print(surahAnnas.number);
  // print(surahAnnas.toJson());
  Uri urlAnnas =  Uri.parse("https://api.quran.gading.dev/surah/${surahAnnas.number}");
  var resAnnas = await http.get(urlAnnas);
  Map<String,dynamic> daataAnnas =  (json.decode(resAnnas.body) as Map<String,dynamic>)["data"];
  /**Mengubah  dari data api (raw data/jsonData) menjadi Model Data**/
  DetailSurah annas = DetailSurah.fromJson(daataAnnas);
  print(annas.verses[0].text.transliteration.en);


}
// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());
//
//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);
//
//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();
//
//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }
