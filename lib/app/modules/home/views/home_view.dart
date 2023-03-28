import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:testing/app/assets/colors.dart';
import 'package:testing/app/data/models/Surah.dart';
import 'package:testing/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quki'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () => Get.toNamed(Routes.SEARCH),
              icon: Icon(Icons.search))
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Assalamualaikum",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: colorPurpleDark),
              ),
              SizedBox(height: 20),
              GetBuilder<HomeController>(builder: (cLastRead) {
                return FutureBuilder<List<Map<String, dynamic>>>(
                  future: cLastRead.getLastRead(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.data == null ||
                        snapshot.data?.isEmpty == true) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(colors: [
                              colorPurpleLight,
                              colorPurplePrimary
                            ])),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () => Get.toNamed(Routes.LAST_READ),
                            child: Container(
                              height: 150,
                              width: Get.width,
                              child: Stack(
                                children: [
                                  Positioned(
                                      bottom: -30,
                                      right: 0,
                                      child: Opacity(
                                        opacity: 0.5,
                                        child: Container(
                                            width: 150,
                                            height: 150,
                                            child: Image.asset(
                                              "assets/images/alquran.png",
                                              fit: BoxFit.contain,
                                            )),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.menu_book_rounded,
                                                color: colorWhite),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Data Last Read Belum ada",
                                              style:
                                                  TextStyle(color: colorWhite),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "Kamu bisa menambahkannya \ndengan :",
                                          style: TextStyle(
                                              color: colorWhite, fontSize: 12),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Save Bookmark \nPilih Last Read",
                                          style: TextStyle(
                                              color: colorWhite, fontSize: 12),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      Map<String, dynamic> dataLastRead = snapshot.data![0];
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(colors: [
                              colorPurpleLight,
                              colorPurplePrimary
                            ])),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () => Get.toNamed(Routes.LAST_READ),
                            child: Container(
                              height: 150,
                              width: Get.width,
                              child: Stack(
                                children: [
                                  Positioned(
                                      bottom: -30,
                                      right: 0,
                                      child: Opacity(
                                        opacity: 0.5,
                                        child: Container(
                                            width: 150,
                                            height: 150,
                                            child: Image.asset(
                                              "assets/images/alquran.png",
                                              fit: BoxFit.contain,
                                            )),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.menu_book_rounded,
                                                color: colorWhite),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Terakhir di baca",
                                              style:
                                                  TextStyle(color: colorWhite),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "${dataLastRead['surah'].toString().replaceAll("+", "'")}",
                                          style: TextStyle(color: colorWhite),
                                        ),
                                        Text(
                                          "Juz ${dataLastRead['juz']} | Ayat ${dataLastRead['ayat']}",
                                          style: TextStyle(color: colorWhite),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  },
                );
              }),
              TabBar(
                  indicatorColor: colorPurpleLight,
                  labelColor: colorPurpleDark,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(
                      child: Text(
                        "Surah",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Juz",
                      ),
                    ),
                    Tab(
                      child: Text(
                        "Bookmark",
                      ),
                    )
                  ]),
              Expanded(
                child: TabBarView(children: [
                  FutureBuilder(
                      future: controller.getAllSurah(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                List<String> allSurah = [];
                                Surah surah = snapshot.data![index];
                                return ListTile(
                                  onTap: () {
                                    Get.toNamed(Routes.DETAIL_ITEM,
                                        arguments: surah);
                                  },
                                  leading: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/bgnumber.png"),
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "${surah.number}",
                                        style:
                                            TextStyle(color: colorPurpleDark),
                                      ))),
                                  title: Text(
                                    "${surah.name?.transliteration?.id ?? 'Gagal memuat..'} | (${surah.name?.translation?.id ?? ''})",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                      "${surah.numberOfVerses ?? 'Gagal memuat..'} Ayat | ${surah.revelation?.id ?? ''}"),
                                  trailing: Text("${surah.name?.short}"),
                                );
                              });
                        }
                      }),
                  ListView.builder(
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => Get.toNamed(Routes.DETAIL_JUZ,
                            arguments: "${index + 1}"),
                        leading: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/bgnumber.png"),
                              ),
                            ),
                            child: Center(
                                child: Text(
                              "${index + 1}",
                              style: TextStyle(color: colorPurpleDark),
                            ))),
                        title: Text("Juz ${index + 1}"),
                      );
                    },
                  ),
                  GetBuilder<HomeController>(
                    builder: (cBookmark) {
                      return FutureBuilder<List<Map<String, dynamic>>>(
                        future: cBookmark.getBookmark(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.data?.length == 0) {
                            return Center(
                              child: Text(""),
                            );
                          }
                          return ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> data = snapshot.data![index];
                              return ListTile(
                                onTap: () {
                                  print(index);
                                },
                                leading: CircleAvatar(
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                        color: colorWhite,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  backgroundColor: colorPurpleLight,
                                ),
                                title: Text(
                                  "${data['surah'].toString().replaceAll("+", "'")}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    "Ayat ${data['ayat']} | Juz ke ${data['juz']}"),
                                trailing: IconButton(
                                  onPressed: () {
                                    cBookmark.deleteBookmarkById(data['id']);
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
