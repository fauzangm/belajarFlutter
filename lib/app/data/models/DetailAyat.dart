// To parse this JSON data, do
//
//     final detailAyat = detailAyatFromJson(jsonString);

import 'dart:convert';

DetailAyat detailAyatFromJson(String str) =>
    DetailAyat.fromJson(json.decode(str));

String detailAyatToJson(DetailAyat data) => json.encode(data.toJson());

class DetailAyat {
  DetailAyat({
    required this.number,
    required this.meta,
    required this.text,
    required this.translation,
    required this.audio,
    required this.tafsir,
    required this.surah,
  });

  Number number;
  Meta meta;
  Text text;
  Translation translation;
  Audio audio;
  DetailAyatTafsir tafsir;
  Surah? surah;

  factory DetailAyat.fromJson(Map<String, dynamic> json) => DetailAyat(
        number: Number.fromJson(json["number"]),
        meta: Meta.fromJson(json["meta"]),
        text: Text.fromJson(json["text"]),
        translation: Translation.fromJson(json["translation"]),
        audio: Audio.fromJson(json["audio"]),
        tafsir: DetailAyatTafsir.fromJson(json["tafsir"]),
        surah: json["surah"] == null ? null : Surah.fromJson(json["surah"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number.toJson(),
        "meta": meta.toJson(),
        "text": text.toJson(),
        "translation": translation.toJson(),
        "audio": audio.toJson(),
        "tafsir": tafsir.toJson(),
        "surah": surah?.toJson(),
      };
}

class Audio {
  Audio({
    required this.primary,
    required this.secondary,
  });

  String primary;
  List<String> secondary;

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        primary: json["primary"],
        secondary: List<String>.from(json["secondary"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "primary": primary,
        "secondary": List<dynamic>.from(secondary.map((x) => x)),
      };
}

class Meta {
  Meta({
    required this.juz,
    required this.page,
    required this.manzil,
    required this.ruku,
    required this.hizbQuarter,
    required this.sajda,
  });

  int juz;
  int page;
  int manzil;
  int ruku;
  int hizbQuarter;
  Sajda sajda;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        juz: json["juz"],
        page: json["page"],
        manzil: json["manzil"],
        ruku: json["ruku"],
        hizbQuarter: json["hizbQuarter"],
        sajda: Sajda.fromJson(json["sajda"]),
      );

  Map<String, dynamic> toJson() => {
        "juz": juz,
        "page": page,
        "manzil": manzil,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
        "sajda": sajda.toJson(),
      };
}

class Sajda {
  Sajda({
    required this.recommended,
    required this.obligatory,
  });

  bool recommended;
  bool obligatory;

  factory Sajda.fromJson(Map<String, dynamic> json) => Sajda(
        recommended: json["recommended"],
        obligatory: json["obligatory"],
      );

  Map<String, dynamic> toJson() => {
        "recommended": recommended,
        "obligatory": obligatory,
      };
}

class Number {
  Number({
    required this.inQuran,
    required this.inSurah,
  });

  int inQuran;
  int inSurah;

  factory Number.fromJson(Map<String, dynamic> json) => Number(
        inQuran: json["inQuran"],
        inSurah: json["inSurah"],
      );

  Map<String, dynamic> toJson() => {
        "inQuran": inQuran,
        "inSurah": inSurah,
      };
}

class Surah {
  Surah({
    required this.number,
    required this.sequence,
    required this.numberOfVerses,
    required this.name,
    required this.revelation,
    required this.tafsir,
    required this.preBismillah,
  });

  int number;
  int sequence;
  int numberOfVerses;
  Name name;
  Revelation revelation;
  SurahTafsir tafsir;
  PreBismillah preBismillah;

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        number: json["number"],
        sequence: json["sequence"],
        numberOfVerses: json["numberOfVerses"],
        name: Name.fromJson(json["name"]),
        revelation: Revelation.fromJson(json["revelation"]),
        tafsir: SurahTafsir.fromJson(json["tafsir"]),
        preBismillah: PreBismillah.fromJson(json["preBismillah"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "sequence": sequence,
        "numberOfVerses": numberOfVerses,
        "name": name.toJson(),
        "revelation": revelation.toJson(),
        "tafsir": tafsir.toJson(),
        "preBismillah": preBismillah.toJson(),
      };
}

class Name {
  Name({
    required this.short,
    required this.long,
    required this.transliteration,
    required this.translation,
  });

  String short;
  String long;
  Translation transliteration;
  Translation translation;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        short: json["short"],
        long: json["long"],
        transliteration: Translation.fromJson(json["transliteration"]),
        translation: Translation.fromJson(json["translation"]),
      );

  Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
        "transliteration": transliteration.toJson(),
        "translation": translation.toJson(),
      };
}

class Translation {
  Translation({
    required this.en,
    required this.id,
  });

  String en;
  String id;

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
        en: json["en"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
        "id": id,
      };
}

class PreBismillah {
  PreBismillah({
    required this.text,
    required this.translation,
    required this.audio,
  });

  Text text;
  Translation translation;
  Audio audio;

  factory PreBismillah.fromJson(Map<String, dynamic> json) => PreBismillah(
        text: Text.fromJson(json["text"]),
        translation: Translation.fromJson(json["translation"]),
        audio: Audio.fromJson(json["audio"]),
      );

  Map<String, dynamic> toJson() => {
        "text": text.toJson(),
        "translation": translation.toJson(),
        "audio": audio.toJson(),
      };
}

class Text {
  Text({
    required this.arab,
    required this.transliteration,
  });

  String arab;
  Transliteration transliteration;

  factory Text.fromJson(Map<String, dynamic> json) => Text(
        arab: json["arab"],
        transliteration: Transliteration.fromJson(json["transliteration"]),
      );

  Map<String, dynamic> toJson() => {
        "arab": arab,
        "transliteration": transliteration.toJson(),
      };
}

class Transliteration {
  Transliteration({
    required this.en,
  });

  String en;

  factory Transliteration.fromJson(Map<String, dynamic> json) =>
      Transliteration(
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "en": en,
      };
}

class Revelation {
  Revelation({
    required this.arab,
    required this.en,
    required this.id,
  });

  String arab;
  String en;
  String id;

  factory Revelation.fromJson(Map<String, dynamic> json) => Revelation(
        arab: json["arab"],
        en: json["en"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "arab": arab,
        "en": en,
        "id": id,
      };
}

class SurahTafsir {
  SurahTafsir({
    required this.id,
  });

  String id;

  factory SurahTafsir.fromJson(Map<String, dynamic> json) => SurahTafsir(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class DetailAyatTafsir {
  DetailAyatTafsir({
    required this.id,
  });

  Id id;

  factory DetailAyatTafsir.fromJson(Map<String, dynamic> json) =>
      DetailAyatTafsir(
        id: Id.fromJson(json["id"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id.toJson(),
      };
}

class Id {
  Id({
    required this.short,
    required this.long,
  });

  String short;
  String long;

  factory Id.fromJson(Map<String, dynamic> json) => Id(
        short: json["short"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
      };
}
