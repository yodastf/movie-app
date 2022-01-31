// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_tv_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularTvResponse _$PopularTvResponseFromJson(Map<String, dynamic> json) {
  return PopularTvResponse(
    page: json['page'] as int,
    tvs: (json['results'] as List<dynamic>)
        .map((e) => TvPopular.fromJson(e as Map<String, dynamic>))
        .toList(),
    totalResults: json['total_results'] as int,
    totalPages: json['total_pages'] as int,
  );
}

Map<String, dynamic> _$PopularTvResponseToJson(PopularTvResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.tvs.map((e) => e.toJson()).toList(),
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
    };
