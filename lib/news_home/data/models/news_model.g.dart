// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsResponse _$NewsResponseFromJson(Map<String, dynamic> json) => NewsResponse(
      meta: Meta.fromJson(json['meta'] as Map<String, dynamic>),
      data: (json['data'] as List<dynamic>)
          .map((e) => NewsData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewsResponseToJson(NewsResponse instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'data': instance.data,
    };

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
      found: (json['found'] as num).toInt(),
      returned: (json['returned'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      page: (json['page'] as num).toInt(),
    );

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
      'found': instance.found,
      'returned': instance.returned,
      'limit': instance.limit,
      'page': instance.page,
    };

NewsData _$NewsDataFromJson(Map<String, dynamic> json) => NewsData(
      uuid: json['uuid'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$NewsDataToJson(NewsData instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
    };
