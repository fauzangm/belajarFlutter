import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:testing/app/routes/app_pages.dart';
import '../controllers/introduction_controller.dart';

class IntroductionView extends GetView<IntroductionController> {
  const IntroductionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("QUKI",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          Text(
            "Qur'an Kita",
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Container(child: Lottie.asset("assets/lotties/splashbg.json")),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.HOME),
              child: Text("Mulai"))
        ],
      ),
    ));
  }
}
