import 'package:json_annotation/json_annotation.dart';

part 'news_model.g.dart';

@JsonSerializable()
class NewsResponse {
  final Meta meta;
  final List<NewsData> data;

  NewsResponse({required this.meta, required this.data});

  factory NewsResponse.fromJson(Map<String, dynamic> json) => _$NewsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewsResponseToJson(this);
}

@JsonSerializable()
class Meta {
  final int found;
  final int returned;
  final int limit;
  final int page;

  Meta({required this.found, required this.returned, required this.limit, required this.page});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}

@JsonSerializable()
class NewsData {
  final String uuid;
  final String title;
  final String description;
  @JsonKey(name: "image_url")
  final String? imageUrl;

  NewsData({
    required this.uuid,
    required this.title,
    required this.description,
    this.imageUrl,
  });
  factory NewsData.fromJson(Map<String, dynamic> json) => _$NewsDataFromJson(json);

  Map<String, dynamic> toJson() => _$NewsDataToJson(this);
}
