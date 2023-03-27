import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:testing/app/assets/colors.dart';
import 'package:testing/app/data/models/DetailSurah.dart' as detail;
import 'package:testing/app/data/models/Surah.dart';
import 'package:testing/app/routes/app_pages.dart';

import '../controllers/detail_item_controller.dart';

class DetailItemView extends GetView<DetailItemController> {
  final Surah surah = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              'Surah ${surah.name?.transliteration?.id?.toUpperCase() ?? 'Error'}'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      colors: [colorPurpleLight, colorPurpleDark])),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  Text('${surah.name?.transliteration?.id?.toUpperCase()}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: colorWhite)),
                  Text('(${surah.name?.translation?.id?.toUpperCase()})',
                      style: TextStyle(fontSize: 14, color: colorWhite)),
                  Text(
                      '(${surah.numberOfVerses} Ayat | ${surah.revelation?.id})',
                      style: TextStyle(fontSize: 14, color: colorWhite)),
                ]),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder<detail.DetailSurah>(
                future: controller.getDetailSurah(surah.number.toString()),
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
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data?.verses?.length ?? 0,
                        itemBuilder: (context, index) {
                          if (snapshot.data?.verses?.length == 0 ||
                              snapshot.data?.verses == null) {
                            return SizedBox();
                          }
                          detail.Verse? ayat = snapshot.data?.verses?[index];
                          return GestureDetector(
                            onTap: () => Get.defaultDialog(
                              backgroundColor: colorPurpleLight.withOpacity(1),
                              title: "Tafsir",
                              titleStyle:
                                  TextStyle(fontWeight: FontWeight.bold),
                              content: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  child: (Text(
                                    "${surah.tafsir?.id ?? 'Tidak ada tafsir'}",
                                    textAlign: TextAlign.justify,
                                  )),
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: colorPurpleLight.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
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
                                              child: Text("${index + 1}")),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(Icons
                                                    .bookmark_add_outlined)),
                                            IconButton(
                                                onPressed: () {
                                                  controller.playAudio(
                                                      ayat?.audio?.primary);
                                                },
                                                icon: Icon(Icons.play_arrow)),
                                          ],
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
                                  "${ayat?.text?.transliteration.en}",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic),
                                  textAlign: TextAlign.end,
                                ),
                                SizedBox(height: 25),
                                Text(
                                  "${ayat?.translation?.id}",
                                  style: TextStyle(fontSize: 15),
                                  textAlign: TextAlign.justify,
                                ),
                                SizedBox(height: 50)
                              ],
                            ),
                          );
                        });
                  }
                })
          ],
        ));
  }
}
