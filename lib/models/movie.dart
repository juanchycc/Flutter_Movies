// ignore_for_file: constant_identifier_names

import 'dart:convert' show json;

class Movie {
    Movie({
        this.adult,
        this.backdropPath,
        this.genreIds,
        this.id,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount,
    });

    bool? adult;
    String? backdropPath;
    List<int?>? genreIds;
    int? id;
    String? originalLanguage;
    String? originalTitle;
    String? overview;
    double? popularity;
    String? posterPath;
    String? releaseDate;
    String? title;
    bool? video;
    double? voteAverage;
    int? voteCount;

    String? heroId;

    String get getImg {

      if ( posterPath == null ) return 'https://via.placeholder.com/150x150';

      return 'https://image.tmdb.org/t/p/w500$posterPath';
    }

    String get getBackdropPath {

      if ( backdropPath == null ) return 'https://via.placeholder.com/150x150';

      return 'https://image.tmdb.org/t/p/w500$backdropPath';
    }

    factory Movie.fromJson(String str) => Movie.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Movie.fromMap(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: json["genre_ids"] == null ? [] : List<int?>.from(json["genre_ids"]!.map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
    );

    Map<String, dynamic> toMap() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": genreIds == null ? [] : List<dynamic>.from(genreIds!.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
    };
}
