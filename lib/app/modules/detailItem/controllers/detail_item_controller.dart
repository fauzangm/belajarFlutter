import 'dart:ffi';

import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:testing/app/data/models/DetailSurah.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailItemController extends GetxController {
  //TODO: Implement DetailItemController

  final player = AudioPlayer();
  Future<DetailSurah> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah/$id");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

    print(data.toString());
    return DetailSurah.fromJson(data);
  }

  void playAudio(String? url) async {
    if (url != null) {
      // Catching errors at load time
      try {
        await player.setUrl(url);
        await player.play();
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

  @override
  void onClose() {
    player.stop();
    player.dispose();
    super.onClose();
  }
}
