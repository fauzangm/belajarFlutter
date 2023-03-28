import 'dart:ffi';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testing/app/assets/colors.dart';
import 'package:testing/app/data/db/bookmark.dart';
import 'package:testing/app/data/models/DetailJuz.dart';
import 'package:testing/app/data/models/DetailSurah.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailItemController extends GetxController {
  //TODO: Implement DetailItemController
  DatabaseManager database = DatabaseManager.instance;
  Verse? lastVerse;
  // RxString KondisiAudio = "stop".obs;
  final player = AudioPlayer();
  Future<DetailSurah> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah/$id");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

    print(data.toString());
    return DetailSurah.fromJson(data);
  }

  void playAudio(Verse? ayat) async {
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
        await player.setUrl(ayat!.audio!.primary);
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

  void pauseAudio(Verse ayat) async {
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

  void resumeAudio(Verse ayat) async {
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

  void stopAudio(Verse ayat) async {
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

  void addBookMark(
      bool lastRead, DetailSurah surah, Verse ayat, int indexAyat) async {
    Database db = await database.db;
    bool flagExist = false;
    if (lastRead == false) {
      await db.delete("bookmark", where: "last_read = 0");
    } else {
      List checkData = await db.query("bookmark",
          where:
              "surah = '${surah.name!.transliteration!.id}' and ayat = ${ayat.number!.inSurah} and juz = ${ayat.meta!.juz} and via = 'surah' and index_ayat = $indexAyat and last_read = 1");
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
        "surah": "${surah.name!.transliteration!.id}",
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

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
