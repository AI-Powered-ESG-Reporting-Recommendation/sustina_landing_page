import 'package:json_annotation/json_annotation.dart';

part 'classification_models.g.dart';

@JsonSerializable()
class SectorModel {
  const SectorModel({required this.id, required this.name});

  final String id;
  final String name;

  factory SectorModel.fromJson(Map<String, dynamic> json) =>
      _$SectorModelFromJson(json);

  Map<String, dynamic> toJson() => _$SectorModelToJson(this);
}

@JsonSerializable()
class IndustryModel {
  const IndustryModel({required this.id, required this.name});

  final String id;
  final String name;

  factory IndustryModel.fromJson(Map<String, dynamic> json) =>
      _$IndustryModelFromJson(json);

  Map<String, dynamic> toJson() => _$IndustryModelToJson(this);
}

@JsonSerializable()
class SubIndustryModel {
  const SubIndustryModel({required this.id, required this.name});

  final String id;
  final String name;

  factory SubIndustryModel.fromJson(Map<String, dynamic> json) =>
      _$SubIndustryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubIndustryModelToJson(this);
}
