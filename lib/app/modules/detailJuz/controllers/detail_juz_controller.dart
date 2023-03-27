import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:testing/app/data/models/DetailJuz.dart';

// sempet problem ternyata model data juz yg gk sesuai sama reponse ^_^
class DetailJuzController extends GetxController {
  //TODO: Implement DetailJuzController

  Future<DetailJuz> getDetailJuz(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/juz/$id");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];
    return DetailJuz.fromJson(data);
  }
}
