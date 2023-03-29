import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testing/app/assets/colors.dart';
import 'package:testing/app/data/db/bookmark.dart';
import 'package:testing/app/data/models/DetailJuz.dart';
import 'package:testing/app/data/models/DetailSurah.dart';

// sempet problem ternyata model data juz yg gk sesuai sama reponse ^_^
class DetailJuzController extends GetxController {
  //TODO: Implement DetailJuzController
  DatabaseManager database = DatabaseManager.instance;
  Verses? lastVerse;
  final player = AudioPlayer();
  Future<DetailJuz> getDetailJuz(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/juz/$id");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];
    return DetailJuz.fromJson(data);
  }

  void playAudio(Verses? ayat) async {
    if (ayat?.audio?.primary != null) {
      // Catching errors at load time
      try {
        if (lastVerse == null) {
          lastVerse = ayat;
        }

        lastVerse!.kondisiAudio = "stop";
        lastVerse = ayat;
        lastVerse!.kondisiAudio = "stop";
        update();

        await player.stop();
        await player.setUrl(ayat!.audio!.primary.toString());
        ayat.kondisiAudio = "playing";
        update();
        await player.play();
        ayat.kondisiAudio = "stop";
        update();
        await player.stop();
      } on PlayerException catch (e) {
        Get.defaultDialog(
            title: "Terjadi Kesalahan",
            middleText: "Error message: ${e.message}");
      } on PlayerInterruptedException catch (e) {
        Get.defaultDialog(
            title: "Terjadi Kesalahan",
            middleText: "Connection aborted: ${e.message}");
      } catch (e) {
        Get.defaultDialog(
            title: "Terjadi Kesalahan", middleText: "An error occured:: ${e}");
        print('An error occured: $e');
      }
    } else {
      Get.defaultDialog(
          title: "Terjadi Kesalahan", middleText: "Audio tidak ditemukan");
    }
  }

  void pauseAudio(Verses ayat) async {
    try {
      await player.pause();
      ayat.kondisiAudio = "pause";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}");
    } catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan", middleText: "An error occured:: ${e}");
      print('An error occured: $e');
    }
  }

  void resumeAudio(Verses ayat) async {
    try {
      ayat.kondisiAudio = "playing";
      update();
      await player.play();
      ayat.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}");
    } catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan", middleText: "An error occured:: ${e}");
      print('An error occured: $e');
    }
  }

  void stopAudio(Verses ayat) async {
    try {
      await player.stop();
      ayat.kondisiAudio = "stop";
      update();
    } on PlayerException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Error message: ${e.message}");
    } on PlayerInterruptedException catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Connection aborted: ${e.message}");
    } catch (e) {
      Get.defaultDialog(
          title: "Terjadi Kesalahan", middleText: "An error occured:: ${e}");
      print('An error occured: $e');
    }
  }

  Future<void> addBookMark(
      bool lastRead, DetailSurah surah, Verses ayat, int indexAyat) async {
    Database db = await database.db;
    bool flagExist = false;
    if (lastRead == false) {
      await db.delete("bookmark", where: "last_read = 0");
    } else {
      List checkData = await db.query("bookmark",
          columns: ["surah", "ayat", "juz", "via", "index_ayat", "last_read"],
          where:
              "surah = '${surah.name!.transliteration!.id!.replaceAll("'", "+")}' and ayat = ${ayat.number!.inSurah} and juz = ${ayat.meta!.juz} and via = 'surah' and index_ayat = $indexAyat and last_read = 1");
      if (checkData.length != 0) {
        print(checkData);
        flagExist = true;
      } else {
        flagExist = false;
        print(flagExist);
      }
    }
    if (flagExist == false) {
      await db.insert("bookmark", {
        "surah": "${surah.name!.transliteration!.id!.replaceAll("'", "+")}",
        "ayat": ayat.number!.inSurah,
        "juz": ayat.meta!.juz,
        "via": "surah",
        "index_ayat": indexAyat,
        "last_read": lastRead == true ? 1 : 0
      });

      Get.back(); //tutup dialog
      Get.snackbar("Berhasil", "Berhasil menambahkan bookmark",
          colorText: colorWhite);
      var data = await db.query("bookmark");
      print(data);
    } else {
      Get.back(); //tutup dialog
      Get.snackbar("Oopss", "Bookmark telah tersedia", colorText: colorWhite);
    }
  }
}
