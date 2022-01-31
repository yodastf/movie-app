import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:themoviedb/domain/entity/movie_date_parser.dart';

part 'tv_popular.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TvPopular {
  final String? posterPath;
  final double popularity;
  final int id;
  final String? backdropPath;
  final double voteAverage;
  final String overview;
  @JsonKey(fromJson: parseMovieDateFromString)
  final DateTime? firstAirDate;
  final List<String> originCountry;
  final List<int> genreIds;
  final String originalLanguage;
  final int voteCount;
  final String name;
  final String originalName;
  TvPopular({
    required this.posterPath,
    required this.popularity,
    required this.id,
    required this.backdropPath,
    required this.voteAverage,
    required this.overview,
    required this.firstAirDate,
    required this.originCountry,
    required this.genreIds,
    required this.originalLanguage,
    required this.voteCount,
    required this.name,
    required this.originalName,
  });
factory TvPopular.fromJson(Map<String,dynamic> json) => _$TvPopularFromJson(json);
  Map<String,dynamic> toJson() => _$TvPopularToJson(this);
}