import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'tv_details_credit.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake,explicitToJson: true)
class TvDetailsCredit {
  final List<Cast> cast;
  final List<Crew> crew;

  TvDetailsCredit({
    required this.cast,
    required this.crew,

  });

  factory TvDetailsCredit.fromJson(Map<String,dynamic> json) => _$TvDetailsCreditFromJson(json);
  Map<String,dynamic> toJson() => _$TvDetailsCreditToJson(this);   
}
@JsonSerializable(fieldRename: FieldRename.snake,explicitToJson: true)
class Cast {
  final bool? adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String character;
  final String creditId;
  final int order;
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.character,
    required this.creditId,
    required this.order,
  });

 factory Cast.fromJson(Map<String,dynamic> json) => _$CastFromJson(json);
  Map<String,dynamic> toJson() => _$CastToJson(this); 
}
@JsonSerializable(fieldRename: FieldRename.snake,explicitToJson: true)
class Crew {
  final bool? adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String creditId;
  final String department;
  final String job;
  Crew({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.creditId,
    required this.department,
    required this.job,
  });

 factory Crew.fromJson(Map<String,dynamic> json) => _$CrewFromJson(json);
  Map<String,dynamic> toJson() => _$CrewToJson(this);
}
@JsonSerializable(fieldRename: FieldRename.snake,explicitToJson: true)
class ProfilePath {
  const ProfilePath();
    factory ProfilePath.fromJson(Map<String,dynamic> json) => _$ProfilePathFromJson(json);
  Map<String,dynamic> toJson() => _$ProfilePathToJson(this);
}