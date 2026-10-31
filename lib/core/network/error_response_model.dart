import 'package:json_annotation/json_annotation.dart';

part 'error_response_model.g.dart';

@JsonSerializable()
class ErrorResponseModel {
  final bool success;
  final String message;
  final List? error;
  final String stack;

  ErrorResponseModel({
    required this.success,
    required this.message,
    required this.error,
    required this.stack,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseModelToJson(this);
}
