import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testing/app/data/db/bookmark.dart';
import 'package:testing/app/data/models/Surah.dart';
import 'package:testing/app/data/models/DetailJuz.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  DatabaseManager database = DatabaseManager.instance;
  Future<List<Surah>> getAllSurah() async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah");
    var res = await http.get(url);

    List data = (json.decode(res.body) as Map<String, dynamic>)["data"];
    if (data == null || data.isEmpty) {
      return [];
    } else {
      return data.map((e) => Surah.fromJson(e)).toList();
    }
  }

  Future<List<Map<String, dynamic>>> getBookmark() async {
    Database db = await database.db;
    List<Map<String, dynamic>> allBookmark =
        await db.query("bookmark", where: "last_read = 1");
    return allBookmark;
  }

  Future<List<Map<String, dynamic>>> getLastRead() async {
    Database db = await database.db;
    List<Map<String, dynamic>> allBookmark =
        await db.query("bookmark", where: "last_read = 0");
    return allBookmark;
  }

  void deleteBookmarkById(int id) async {
    Database db = await database.db;
    await db.delete("bookmark", where: "id = $id");
    update();
    Get.back();
    Get.snackbar("Berhasil", "Bookmark berhasil dihapus");
  }
}
