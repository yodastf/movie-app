import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:themoviedb/domain/entity/movie_date_parser.dart';
import 'package:themoviedb/domain/entity/tv_details_credit.dart';
import 'package:themoviedb/domain/entity/tv_details_video.dart';

part 'tv_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class TvDetails {
  final String? backdropPath;
  final List<CreatedBy> createdBy;
  final List<int>? episodeRunTime;
  @JsonKey(fromJson: parseMovieDateFromString)
  final DateTime? firstAirDate;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final bool? inProduction;
  final List<String> languages;
  final String lastAirDate;
  final LastEpisodeToAir lastEpisodeToAir;
  final String name;
  final NextEpisodeToAir? nextEpisodeToAir;
  final List<Network> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterpath;
  final List<ProductionCompanie> productionCompanies;
  final List<ProductionCountrie> productionCountries;
  final List<Season> seasons;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;
  final TvDetailsCredit credits;
  final TvDetailsVideo videos;
  TvDetails({
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterpath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
    required this.credits,
    required this.videos
  });
factory TvDetails.fromJson(Map<String,dynamic> json) => _$TvDetailsFromJson(json);
  Map<String,dynamic> toJson() => _$TvDetailsToJson(this);
  
}

@JsonSerializable(fieldRename: FieldRename.snake)
class CreatedBy {
  final int id;
  final String creditId;
  final String name;
  final int gender;
  final String? profilePath;
  CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    required this.profilePath,
  });

 factory CreatedBy.fromJson(Map<String,dynamic> json) => _$CreatedByFromJson(json);
  Map<String,dynamic> toJson() => _$CreatedByToJson(this);
}
@JsonSerializable(fieldRename: FieldRename.snake)
class Genre {
  final int id;
  final String name;
  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String,dynamic> json) => _$GenreFromJson(json);
  Map<String,dynamic> toJson() => _$GenreToJson(this);
}
@JsonSerializable(fieldRename: FieldRename.snake)
class LastEpisodeToAir {
  final String airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int seasonNumber;
  final String? stillPath;
  final double voteAverage;
  final int voteCount;
  LastEpisodeToAir({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  factory LastEpisodeToAir.fromJson(Map<String,dynamic> json) => _$LastEpisodeToAirFromJson(json);
  Map<String,dynamic> toJson() => _$LastEpisodeToAirToJson(this);
}
@JsonSerializable(fieldRename: FieldRename.snake)
class NextEpisodeToAir {
  const NextEpisodeToAir();
  factory NextEpisodeToAir.fromJson(Map<String,dynamic> json) => _$NextEpisodeToAirFromJson(json);
  Map<String,dynamic> toJson() => _$NextEpisodeToAirToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Network {
  final String name;
  final int id;
  final String? logoPath;
  final String originCountry;
  Network({
    required this.name,
    required this.id,
    required this.logoPath,
    required this.originCountry,
  });

   factory Network.fromJson(Map<String,dynamic> json) => _$NetworkFromJson(json);
   Map<String,dynamic> toJson() => _$NetworkToJson(this);
}
@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCompanie {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;
  ProductionCompanie({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });
factory ProductionCompanie.fromJson(Map<String,dynamic> json) => _$ProductionCompanieFromJson(json);
  Map<String,dynamic> toJson() => _$ProductionCompanieToJson(this);
  
}
@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCountrie {
    @JsonKey(name: 'iso_3166_1')
  final String iso31661;
  final String name;
  ProductionCountrie({
    required this.iso31661,
    required this.name,
  });

  factory ProductionCountrie.fromJson(Map<String,dynamic> json) => _$ProductionCountrieFromJson(json);
  Map<String,dynamic> toJson() => _$ProductionCountrieToJson(this);
}
@JsonSerializable(fieldRename: FieldRename.snake)
class Season {
  final String airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;
  Season({
    required this.airDate,
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
  });

  factory Season.fromJson(Map<String,dynamic> json) => _$SeasonFromJson(json);
  Map<String,dynamic> toJson() => _$SeasonToJson(this);
}
@JsonSerializable(fieldRename: FieldRename.snake)
class SpokenLanguage {
  final String englishName;
  @JsonKey(name: 'iso_639_1')
  final String iso;
  final String name;
  SpokenLanguage({
    required this.englishName,
    required this.iso,
    required this.name,
  });
factory SpokenLanguage.fromJson(Map<String,dynamic> json) => _$SpokenLanguageFromJson(json);
  Map<String,dynamic> toJson() => _$SpokenLanguageToJson(this);
}