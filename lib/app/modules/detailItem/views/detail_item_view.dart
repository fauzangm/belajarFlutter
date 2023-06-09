import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:testing/app/assets/colors.dart';
import 'package:testing/app/data/models/DetailSurah.dart' as detail;
import 'package:testing/app/data/models/Surah.dart';
import 'package:testing/app/modules/home/controllers/home_controller.dart';
import 'package:testing/app/routes/app_pages.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../controllers/detail_item_controller.dart';

class DetailItemView extends GetView<DetailItemController> {
  final homeC = Get.find<HomeController>();
  Map<String, dynamic>? bookmark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Text('Surah ${Get.arguments["name"].toString().toUpperCase()}'),
          centerTitle: true,
        ),
        body: FutureBuilder<detail.DetailSurah>(
            future: controller.getDetailSurah(Get.arguments["number"]),
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
              }
              if (Get.arguments["bookmark"] != null) {
                bookmark = Get.arguments["bookmark"];
                if (bookmark!["index_ayat"] >= 1) {
                  controller.scrollC.scrollToIndex(
                    bookmark!["index_ayat"] + 2,
                    preferPosition: AutoScrollPosition.begin,
                  );
                  print("bookmark = ${bookmark}");
                }
              }

              detail.DetailSurah surah = snapshot.data!;
              return ListView(
                controller: controller.scrollC,
                padding: EdgeInsets.all(20),
                children: [
                  AutoScrollTag(
                    key: ValueKey(0),
                    index: 0,
                    controller: controller.scrollC,
                    child: GestureDetector(
                      onTap: () => Get.defaultDialog(
                        backgroundColor: colorPurpleLight.withOpacity(1),
                        title: "Tafsir",
                        titleStyle: TextStyle(fontWeight: FontWeight.bold),
                        content: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            child: (Text(
                              "${surah.tafsir?.id ?? 'Tidak ada tafsir'}",
                              textAlign: TextAlign.justify,
                            )),
                          ),
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                                colors: [colorPurpleLight, colorPurpleDark])),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(children: [
                            Text(
                                '${surah.name?.transliteration?.id?.toUpperCase()}',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: colorWhite)),
                            Text(
                                '(${surah.name?.translation?.id?.toUpperCase()})',
                                style:
                                    TextStyle(fontSize: 14, color: colorWhite)),
                            Text(
                                '(${surah.numberOfVerses} Ayat | ${surah.revelation?.id})',
                                style:
                                    TextStyle(fontSize: 14, color: colorWhite)),
                          ]),
                        ),
                      ),
                    ),
                  ),
                  AutoScrollTag(
                    key: ValueKey(1),
                    index: 1,
                    controller: controller.scrollC,
                    child: SizedBox(
                      height: 10,
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data?.verses?.length ?? 0,
                      itemBuilder: (context, index) {
                        if (snapshot.data?.verses?.length == 0 ||
                            snapshot.data?.verses == null) {
                          return SizedBox();
                        }
                        detail.Verse? ayat = snapshot.data?.verses?[index];
                        return AutoScrollTag(
                          key: ValueKey(index + 2),
                          index: index + 2,
                          controller: controller.scrollC,
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
                                        child:
                                            Center(child: Text("${index + 1}")),
                                      ),
                                      GetBuilder<DetailItemController>(
                                        builder: (cButton) => Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  Get.defaultDialog(
                                                      title: "BOOKMARK",
                                                      middleText:
                                                          "Pilih jenis bookmark",
                                                      actions: [
                                                        ElevatedButton(
                                                          onPressed: () async {
                                                            await cButton
                                                                .addBookMark(
                                                                    false,
                                                                    snapshot
                                                                        .data!,
                                                                    ayat!,
                                                                    index);

                                                            homeC.update();
                                                          },
                                                          child:
                                                              Text("Last Read"),
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  primary:
                                                                      colorPurplePrimary),
                                                        ),
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              cButton
                                                                  .addBookMark(
                                                                      true,
                                                                      snapshot
                                                                          .data!,
                                                                      ayat!,
                                                                      index);
                                                            },
                                                            child: Text(
                                                                "Bookmark"),
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    primary:
                                                                        colorPurpleLight))
                                                      ]);
                                                },
                                                icon: Icon(Icons
                                                    .bookmark_add_outlined)),
                                            (ayat?.kondisiAudio == "stop")
                                                ? IconButton(
                                                    onPressed: () {
                                                      cButton.playAudio(ayat);
                                                    },
                                                    icon:
                                                        Icon(Icons.play_arrow),
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
                                      )
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
                                    fontSize: 15, fontStyle: FontStyle.italic),
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
                      })
                ],
              );
            }));
  }
}
