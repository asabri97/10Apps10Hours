import 'dart:convert';

Movie movieFromJson(String str) => Movie.fromJson(json.decode(str));

String movieToJson(Movie data) => json.encode(data.toJson());

class Movies {
  Movies({
    required this.page,
    required this.data,
  });

  int page;
  List<Movie> data;

  factory Movies.fromJson(Map<String, dynamic> json) => Movies(
        page: json["page"],
        data: List<Movie>.from(json["data"].map((x) => Movie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Movie {
  int id;
  String name;
  String overwatch;
  String photourl;
  DateTime updateTime;
  DateTime releaseDate;
  double popular;
  double rate;
  int ratedCount;
  String genre;

  Movie({
    required this.id,
    required this.name,
    required this.overwatch,
    required this.photourl,
    required this.updateTime,
    required this.releaseDate,
    required this.popular,
    required this.rate,
    required this.ratedCount,
    required this.genre,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"],
        name: json["name"],
        overwatch: json["overwatch"],
        photourl: json["photourl"],
        updateTime: DateTime.parse(json["updateTime"]),
        releaseDate: DateTime.parse(json["releaseDate"]),
        popular: json["popular"]?.toDouble(),
        rate: json["rate"]?.toDouble(),
        ratedCount: json["ratedCount"],
        genre: json["genre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "overwatch": overwatch,
        "photourl": photourl,
        "updateTime": updateTime.toIso8601String(),
        "releaseDate": releaseDate.toIso8601String(),
        "popular": popular,
        "rate": rate,
        "ratedCount": ratedCount,
        "genre": genre,
      };
}
