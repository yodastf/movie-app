import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'movie_details_videos.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake,explicitToJson: true)
class MovieDetailsVideos {
  
  final List<Result> results;
  MovieDetailsVideos({
  
    required this.results,
  });
  factory MovieDetailsVideos.fromJson(Map<String,dynamic> json) => _$MovieDetailsVideosFromJson(json);
  Map<String,dynamic> toJson() => _$MovieDetailsVideosToJson(this);
  
}
@JsonSerializable(fieldRename: FieldRename.snake,explicitToJson: true)
class Result {
  @JsonKey(name: 'iso_639_1')
  final String iso6391;
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool official;
  final String published_at;
  final String id;
  Result({
    required this.iso6391,
    required this.iso31661,
    required this.name,
    required this.key,
    required this.site,
    required this.size,
    required this.type,
    required this.official,
    required this.published_at,
    required this.id,
  });

  factory Result.fromJson(Map<String,dynamic> json) => _$ResultFromJson(json);
  Map<String,dynamic> toJson() => _$ResultToJson(this);
  
}