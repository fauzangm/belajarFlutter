import 'package:get/get.dart';

import '../modules/detailItem/bindings/detail_item_binding.dart';
import '../modules/detailItem/views/detail_item_view.dart';
import '../modules/detailJuz/bindings/detail_juz_binding.dart';
import '../modules/detailJuz/views/detail_juz_view.dart';
import '../modules/detail_ayat/bindings/detail_ayat_binding.dart';
import '../modules/detail_ayat/views/detail_ayat_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/introduction/bindings/introduction_binding.dart';
import '../modules/introduction/views/introduction_view.dart';
import '../modules/last_read/bindings/last_read_binding.dart';
import '../modules/last_read/views/last_read_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => const IntroductionView(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ITEM,
      page: () => DetailItemView(),
      binding: DetailItemBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_AYAT,
      page: () => DetailAyatView(),
      binding: DetailAyatBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.LAST_READ,
      page: () => LastReadView(),
      binding: LastReadBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_JUZ,
      page: () => const DetailJuzView(),
      binding: DetailJuzBinding(),
    ),
  ];
}
