// To parse this JSON data, do
//
//     final nowPlayingResponse = nowPlayingResponseFromMap(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';
import 'package:peliculas_app/models/models.dart';

class NowPlayingResponse {
    NowPlayingResponse({
        this.dates,
        this.page,
        required this.results,
        this.totalPages,
        this.totalResults,
    });

    Dates? dates;
    int? page;
    List<Movie> results;
    int? totalPages;
    int? totalResults;

    factory NowPlayingResponse.fromJson(String str) => NowPlayingResponse.fromMap(json.decode(str));

    factory NowPlayingResponse.fromMap(Map<String, dynamic> json) => NowPlayingResponse(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        results: json["results"] == null ? [] : List<Movie>.from(json["results"]!.map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toMap() => {
        "dates": dates!.toMap(),
        "page": page,
        // ignore: unnecessary_null_comparison
        "results": results == null ? [] : List<dynamic>.from(results.map((x) => x.toMap())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

class Dates {
    Dates({
        this.maximum,
        this.minimum,
    });

    DateTime? maximum;
    DateTime? minimum;

    factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
    );

    Map<String, dynamic> toMap() => {
        "maximum": "${maximum!.year.toString().padLeft(4, '0')}-${maximum!.month.toString().padLeft(2, '0')}-${maximum!.day.toString().padLeft(2, '0')}",
        "minimum": "${minimum!.year.toString().padLeft(4, '0')}-${minimum!.month.toString().padLeft(2, '0')}-${minimum!.day.toString().padLeft(2, '0')}",
    };
}

