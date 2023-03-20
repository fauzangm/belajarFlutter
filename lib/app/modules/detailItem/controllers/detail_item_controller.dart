import 'package:get/get.dart';
import 'package:testing/app/data/models/DetailSurah.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DetailItemController extends GetxController {
  //TODO: Implement DetailItemController

  Future<DetailSurah> getDetailSurah(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/surah/$id");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];

    print(data.toString());
    return DetailSurah.fromJson(data);
  }
}
