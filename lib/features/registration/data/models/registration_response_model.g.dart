// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegistrationResponseModel _$RegistrationResponseModelFromJson(
  Map<String, dynamic> json,
) => RegistrationResponseModel(
  message: json['message'] as String?,
  registration: json['registration'] == null
      ? null
      : RegistrationDetails.fromJson(
          json['registration'] as Map<String, dynamic>,
        ),
  organization: json['organization'] == null
      ? null
      : OrganizationDetails.fromJson(
          json['organization'] as Map<String, dynamic>,
        ),
  admin: json['admin'] == null
      ? null
      : AdminDetails.fromJson(json['admin'] as Map<String, dynamic>),
  document: json['document'] == null
      ? null
      : DocumentDetails.fromJson(json['document'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RegistrationResponseModelToJson(
  RegistrationResponseModel instance,
) => <String, dynamic>{
  'message': instance.message,
  'registration': instance.registration,
  'organization': instance.organization,
  'admin': instance.admin,
  'document': instance.document,
};

RegistrationDetails _$RegistrationDetailsFromJson(Map<String, dynamic> json) =>
    RegistrationDetails(
      id: json['id'] as String?,
      referenceCode: json['referenceCode'] as String?,
      status: json['status'] as String?,
      submittedAt: json['submittedAt'] as String?,
    );

Map<String, dynamic> _$RegistrationDetailsToJson(
  RegistrationDetails instance,
) => <String, dynamic>{
  'id': instance.id,
  'referenceCode': instance.referenceCode,
  'status': instance.status,
  'submittedAt': instance.submittedAt,
};

OrganizationDetails _$OrganizationDetailsFromJson(Map<String, dynamic> json) =>
    OrganizationDetails(
      id: json['id'] as String?,
      legalName: json['legalName'] as String?,
      hqCountry: json['hqCountry'] as String?,
      firstReportingYear: json['firstReportingYear'],
      subIndustryId: json['subIndustryId'] as String?,
    );

Map<String, dynamic> _$OrganizationDetailsToJson(
  OrganizationDetails instance,
) => <String, dynamic>{
  'id': instance.id,
  'legalName': instance.legalName,
  'hqCountry': instance.hqCountry,
  'firstReportingYear': instance.firstReportingYear,
  'subIndustryId': instance.subIndustryId,
};

AdminDetails _$AdminDetailsFromJson(Map<String, dynamic> json) =>
    AdminDetails(id: json['id'] as String?, email: json['email'] as String?);

Map<String, dynamic> _$AdminDetailsToJson(AdminDetails instance) =>
    <String, dynamic>{'id': instance.id, 'email': instance.email};

DocumentDetails _$DocumentDetailsFromJson(Map<String, dynamic> json) =>
    DocumentDetails(
      id: json['id'] as String?,
      originalName: json['originalName'] as String?,
      mimeType: json['mimeType'] as String?,
    );

Map<String, dynamic> _$DocumentDetailsToJson(DocumentDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'originalName': instance.originalName,
      'mimeType': instance.mimeType,
    };
