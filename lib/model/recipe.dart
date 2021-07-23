import 'dart:convert';

Recipe recipeFromJson(String str) => Recipe.fromJson(json.decode(str));

String recipeToJson(Recipe data) => json.encode(data.toJson());

class Recipe {
  Recipe({
    this.method,
    this.status,
    this.results,
  });

  String? method;
  bool? status;
  List<Result>? results;

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        method: json["method"],
        status: json["status"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "method": method,
        "status": status,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.title,
    this.thumb,
    this.key,
    this.times,
    this.portion,
    this.dificulty,
  });

  String? title;
  String? thumb;
  String? key;
  String? times;
  Portion? portion;
  Dificulty? dificulty;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        title: json["title"],
        thumb: json["thumb"],
        key: json["key"],
        times: json["times"],
        portion: portionValues.map[json["portion"]],
        dificulty: dificultyValues.map[json["dificulty"]],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "thumb": thumb,
        "key": key,
        "times": times,
        "portion": portionValues.reverse![portion!],
        "dificulty": dificultyValues.reverse![dificulty!],
      };
}

enum Dificulty { CUKUP_RUMIT, MUDAH, EMPTY }

final dificultyValues = EnumValues({
  "Cukup Rumit": Dificulty.CUKUP_RUMIT,
  "": Dificulty.EMPTY,
  "Mudah": Dificulty.MUDAH
});

enum Portion { THE_3_PORSI, THE_4_PORSI }

final portionValues = EnumValues(
    {"3 Porsi": Portion.THE_3_PORSI, "4 Porsi": Portion.THE_4_PORSI});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
