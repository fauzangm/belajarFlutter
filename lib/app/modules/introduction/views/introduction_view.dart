import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:testing/app/assets/colors.dart';
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
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: colorPurplePrimary)),
          SizedBox(height: 20),
          Text(
            "Qur'an Kita",
            style: TextStyle(fontSize: 16, color: colorPurpleGrey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  child: Lottie.asset("assets/lotties/splashbg.json"))),
          SizedBox(
            height: 30,
          ),
          // ElevatedButton(
          //   onPressed: () => Get.offAllNamed(Routes.HOME),
          //   child: Text("Mulai"),

          //   style: ButtonStyle(
          //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //           RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(18.0),
          //               side: BorderSide(color: Color(0xFF431AA1)),
          //               ),
          //               )),
          // ),

          InkWell(
            onTap: () => Get.offAllNamed(Routes.HOME),
            // customBorder: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(20),
            //     side: BorderSide(color: Color(0xFF431AA1))),
            child: Container(
              padding: EdgeInsets.all(0.0),
              height: 40.0, //MediaQuery.of(context).size.width * .08,
              width: 200.0, //MediaQuery.of(context).size.width * .3,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xFF431AA1)),
                borderRadius: BorderRadius.circular(18.0),
              ),
              child: Row(
                children: <Widget>[
                  LayoutBuilder(builder: (context, constraints) {
                    print(constraints);
                    return Container(
                      height: constraints.maxHeight,
                      width: constraints.maxHeight,
                      decoration: BoxDecoration(
                        color: colorPurpleDark,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.play_arrow,
                        color: colorWhite,
                      ),
                    );
                  }),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Mulai',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 20,
                            color: colorPurplePrimary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
