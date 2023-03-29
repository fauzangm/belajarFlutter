import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:testing/app/assets/colors.dart';
import 'package:testing/app/data/models/DetailJuz.dart' as detail;

import '../controllers/detail_juz_controller.dart';

class DetailJuzView extends GetView<DetailJuzController> {
  final String juzId = Get.arguments;
  detail.DetailJuz? data = detail.DetailJuz();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Juz $juzId'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            FutureBuilder<detail.DetailJuz>(
                future: controller.getDetailJuz(juzId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData) {
                    return Center(
                      child: Text("Tidak ada data"),
                    );
                  } else {
                    data = snapshot.data;
                    // Container(
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(20),
                    //       gradient: LinearGradient(
                    //           colors: [colorPurpleLight, colorPurpleDark])),
                    // child: Stack(
                    // children: [
                    // Positioned(
                    //     bottom: -10,
                    //     right: 15,
                    //     child: Opacity(
                    //       opacity: 0.5,
                    //       child: Container(
                    //           width: 80,
                    //           height: 80,
                    //           child: Image.asset(
                    //             "assets/images/alquran.png",
                    //             fit: BoxFit.contain,
                    //           )),
                    //     )),
                    // Padding(
                    //   padding: const EdgeInsets.all(20),
                    //   child: Column(
                    //     children: [
                    //       Center(
                    //         child: Text(
                    //           '${snapshot.data?.juzStartInfo}\n\n${snapshot.data?.juzEndInfo}',
                    //           style: TextStyle(color: colorWhite),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 20,
                    // ),

                    // ],
                    // ),
                    // );
                    return ListView.builder(
                      itemCount: snapshot.data?.verses?.length ?? 0,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        detail.Verses? ayat = snapshot.data?.verses?[index];
                        return GestureDetector(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: colorPurpleLight.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/images/bgnumber.png"),
                                              fit: BoxFit.contain)),
                                      child: Center(
                                          child:
                                              Text("${ayat?.number?.inSurah}")),
                                    ),
                                    GetBuilder<DetailJuzController>(
                                      builder: (cButton) => Row(
                                        children: [
                                          // IconButton(
                                          //     onPressed: () {},
                                          //     icon: Icon(
                                          //         Icons.bookmark_add_outlined)),
                                          (ayat?.kondisiAudio == "stop")
                                              ? IconButton(
                                                  onPressed: () {
                                                    cButton.playAudio(ayat);
                                                  },
                                                  icon: Icon(Icons.play_arrow),
                                                )
                                              : Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    (ayat?.kondisiAudio ==
                                                            "playing")
                                                        ? IconButton(
                                                            onPressed: () {
                                                              cButton
                                                                  .pauseAudio(
                                                                      ayat!);
                                                            },
                                                            icon: Icon(
                                                                Icons.pause),
                                                          )
                                                        : IconButton(
                                                            onPressed: () {
                                                              cButton
                                                                  .resumeAudio(
                                                                      ayat!);
                                                            },
                                                            icon: Icon(Icons
                                                                .play_arrow),
                                                          ),
                                                    IconButton(
                                                      onPressed: () {
                                                        controller
                                                            .stopAudio(ayat!);
                                                      },
                                                      icon: Icon(Icons.stop),
                                                    )
                                                  ],
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              "${ayat?.text?.arab}",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.end,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "${ayat?.text?.transliteration?.en}",
                              style: TextStyle(
                                  fontSize: 15, fontStyle: FontStyle.italic),
                              textAlign: TextAlign.end,
                            ),
                            SizedBox(height: 25),
                            Text(
                              "${ayat?.translation?.id}",
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(height: 50),
                          ],
                        ));
                      },
                    );
                  }
                }),
          ],
        ));
  }
}
