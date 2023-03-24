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
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [colorPurpleLight, colorPurplePrimary])),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      style: TextStyle(color: colorWhite),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Al-Fatihah",
                                  style: TextStyle(color: colorWhite),
                                ),
                                Text(
                                  "Juz 1 | Ayat 5",
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
              ),
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
                                          child: Text("${surah.number}"))),
                                  title: Text(
                                      "${surah.name?.transliteration?.id ?? 'Gagal memuat..'} | (${surah.name?.translation?.id ?? ''})"),
                                  subtitle: Text(
                                      "${surah.numberOfVerses ?? 'Gagal memuat..'} Ayat | ${surah.revelation?.id ?? ''}"),
                                  trailing: Text("${surah.name?.short}"),
                                );
                              });
                        }
                      }),
                  Center(child: Text("Page2")),
                  Center(child: Text("Page3"))
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
