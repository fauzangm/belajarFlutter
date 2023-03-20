import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:testing/app/data/models/Surah.dart';
import 'package:testing/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('HomeView'),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: controller.getAllSurah(),
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
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Surah surah = snapshot.data![index];
                      return ListTile(
                        onTap: () {
                          Get.toNamed(Routes.DETAIL_ITEM, arguments: surah);
                        },
                        leading: CircleAvatar(
                          child: Text("${surah.number}"),
                        ),
                        title: Text(
                            "${surah.name?.transliteration?.id ?? 'Gagal memuat..'} | (${surah.name?.translation?.id ?? ''})"),
                        subtitle: Text(
                            "${surah.numberOfVerses ?? 'Gagal memuat..'} Ayat | ${surah.revelation?.id ?? ''}"),
                        trailing: Text("${surah.name?.short}"),
                      );
                    });
              }
            }));
  }
}
