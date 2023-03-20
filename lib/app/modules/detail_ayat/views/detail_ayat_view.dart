import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/DetailSurah.dart' as detail;
import '../controllers/detail_ayat_controller.dart';

class DetailAyatView extends GetView<DetailAyatController> {
  // final detail.DetailSurah detailSurah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ayat "),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailAyatView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
