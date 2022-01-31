import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'tv_details_video.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake,explicitToJson: true)
class TvDetailsVideo {

  final List<Result> results;
  TvDetailsVideo({

    required this.results,
  });
factory TvDetailsVideo.fromJson(Map<String,dynamic> json) => _$TvDetailsVideoFromJson(json);
  Map<String,dynamic> toJson() => _$TvDetailsVideoToJson(this);
  
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
  final bool? official;
  final String publishedAt;
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
    required this.publishedAt,
    required this.id,
  });
factory Result.fromJson(Map<String,dynamic> json) => _$ResultFromJson(json);
  Map<String,dynamic> toJson() => _$ResultToJson(this);
  
}