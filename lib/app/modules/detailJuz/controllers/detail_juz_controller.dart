import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:testing/app/data/models/juz.dart';

class DetailJuzController extends GetxController {
  //TODO: Implement DetailJuzController

  Future<juz> getAllJuz(String id) async {
    Uri url = Uri.parse("https://api.quran.gading.dev/juz/$id");
    var res = await http.get(url);

    Map<String, dynamic> data =
        (json.decode(res.body) as Map<String, dynamic>)["data"];
    return juz.fromJson(data);
  }
}
