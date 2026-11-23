import 'package:json_annotation/json_annotation.dart';

part 'registration_response_model.g.dart';

@JsonSerializable()
class RegistrationResponseModel {
  final String? message;
  final RegistrationDetails? registration;
  final OrganizationDetails? organization;
  final AdminDetails? admin;
  final DocumentDetails? document;

  const RegistrationResponseModel({
    this.message,
    this.registration,
    this.organization,
    this.admin,
    this.document,
  });

  factory RegistrationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegistrationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationResponseModelToJson(this);
}

@JsonSerializable()
class RegistrationDetails {
  final String? id;
  final String? referenceCode;
  final String? status;
  final String? submittedAt;

  const RegistrationDetails({
    this.id,
    this.referenceCode,
    this.status,
    this.submittedAt,
  });

  factory RegistrationDetails.fromJson(Map<String, dynamic> json) =>
      _$RegistrationDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$RegistrationDetailsToJson(this);
}

@JsonSerializable()
class OrganizationDetails {
  final String? id;
  final String? legalName;
  final String? hqCountry;
  final dynamic firstReportingYear;
  final String? subIndustryId;

  const OrganizationDetails({
    this.id,
    this.legalName,
    this.hqCountry,
    this.firstReportingYear,
    this.subIndustryId,
  });

  factory OrganizationDetails.fromJson(Map<String, dynamic> json) =>
      _$OrganizationDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$OrganizationDetailsToJson(this);
}

@JsonSerializable()
class AdminDetails {
  final String? id;
  final String? email;

  const AdminDetails({
    this.id,
    this.email,
  });

  factory AdminDetails.fromJson(Map<String, dynamic> json) =>
      _$AdminDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AdminDetailsToJson(this);
}

@JsonSerializable()
class DocumentDetails {
  final String? id;
  final String? originalName;
  final String? mimeType;

  const DocumentDetails({
    this.id,
    this.originalName,
    this.mimeType,
  });

  factory DocumentDetails.fromJson(Map<String, dynamic> json) =>
      _$DocumentDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentDetailsToJson(this);
}
