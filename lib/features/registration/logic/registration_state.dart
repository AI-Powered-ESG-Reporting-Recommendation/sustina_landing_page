import 'dart:typed_data';

import 'package:suatina_web_project/features/registration/data/models/classification_models.dart';
import 'package:suatina_web_project/features/registration/data/models/registration_response_model.dart';

class RegistrationState {
  const RegistrationState({
    this.sectors = const [],
    this.isSectorsLoading = false,
    this.sectorsError,
    this.selectedSectorId,
    this.industries = const [],
    this.isIndustriesLoading = false,
    this.industriesError,
    this.selectedIndustryId,
    this.subIndustries = const [],
    this.isSubIndustriesLoading = false,
    this.subIndustriesError,
    this.selectedSubIndustryId,
    this.documentBytes,
    this.documentName,
    this.documentSize,
    this.documentError,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.termsAccepted = false,
    this.isSubmitting = false,
    this.submitError,
    this.registrationResponse,
  });

  // Sector Level
  final List<SectorModel> sectors;
  final bool isSectorsLoading;
  final String? sectorsError;
  final String? selectedSectorId;

  // Industry Level
  final List<IndustryModel> industries;
  final bool isIndustriesLoading;
  final String? industriesError;
  final String? selectedIndustryId;

  // Sub-Industry Level
  final List<SubIndustryModel> subIndustries;
  final bool isSubIndustriesLoading;
  final String? subIndustriesError;
  final String? selectedSubIndustryId;

  // Verification Document (PDF)
  final Uint8List? documentBytes;
  final String? documentName;
  final int? documentSize;
  final String? documentError;

  // UI state
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final bool termsAccepted;

  // Submission State
  final bool isSubmitting;
  final String? submitError;
  final RegistrationResponseModel? registrationResponse;

  bool get isSectorSelected =>
      selectedSectorId != null && selectedSectorId!.isNotEmpty;
  bool get isIndustrySelected =>
      selectedIndustryId != null && selectedIndustryId!.isNotEmpty;
  bool get isSubIndustrySelected =>
      selectedSubIndustryId != null && selectedSubIndustryId!.isNotEmpty;
  bool get isDocumentSelected =>
      documentBytes != null && documentBytes!.isNotEmpty;
  bool get isSuccess => registrationResponse != null;

  SectorModel? get currentSector {
    if (selectedSectorId == null) return null;
    try {
      return sectors.firstWhere((s) => s.id == selectedSectorId);
    } catch (_) {
      return null;
    }
  }

  IndustryModel? get currentIndustry {
    if (selectedIndustryId == null) return null;
    try {
      return industries.firstWhere((i) => i.id == selectedIndustryId);
    } catch (_) {
      return null;
    }
  }

  SubIndustryModel? get currentSubIndustry {
    if (selectedSubIndustryId == null) return null;
    try {
      return subIndustries.firstWhere((si) => si.id == selectedSubIndustryId);
    } catch (_) {
      return null;
    }
  }

  RegistrationState copyWith({
    List<SectorModel>? sectors,
    bool? isSectorsLoading,
    String? sectorsError,
    bool clearSectorsError = false,
    String? selectedSectorId,
    bool clearSelectedSector = false,
    List<IndustryModel>? industries,
    bool? isIndustriesLoading,
    String? industriesError,
    bool clearIndustriesError = false,
    String? selectedIndustryId,
    bool clearSelectedIndustry = false,
    List<SubIndustryModel>? subIndustries,
    bool? isSubIndustriesLoading,
    String? subIndustriesError,
    bool clearSubIndustriesError = false,
    String? selectedSubIndustryId,
    bool clearSelectedSubIndustry = false,
    Uint8List? documentBytes,
    String? documentName,
    int? documentSize,
    String? documentError,
    bool clearDocument = false,
    bool clearDocumentError = false,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    bool? termsAccepted,
    bool? isSubmitting,
    String? submitError,
    bool clearSubmitError = false,
    RegistrationResponseModel? registrationResponse,
    bool clearRegistrationResponse = false,
  }) {
    return RegistrationState(
      sectors: sectors ?? this.sectors,
      isSectorsLoading: isSectorsLoading ?? this.isSectorsLoading,
      sectorsError: clearSectorsError ? null : (sectorsError ?? this.sectorsError),
      selectedSectorId: clearSelectedSector
          ? null
          : (selectedSectorId ?? this.selectedSectorId),
      industries: industries ?? this.industries,
      isIndustriesLoading: isIndustriesLoading ?? this.isIndustriesLoading,
      industriesError: clearIndustriesError
          ? null
          : (industriesError ?? this.industriesError),
      selectedIndustryId: clearSelectedIndustry
          ? null
          : (selectedIndustryId ?? this.selectedIndustryId),
      subIndustries: subIndustries ?? this.subIndustries,
      isSubIndustriesLoading:
          isSubIndustriesLoading ?? this.isSubIndustriesLoading,
      subIndustriesError: clearSubIndustriesError
          ? null
          : (subIndustriesError ?? this.subIndustriesError),
      selectedSubIndustryId: clearSelectedSubIndustry
          ? null
          : (selectedSubIndustryId ?? this.selectedSubIndustryId),
      documentBytes: clearDocument ? null : (documentBytes ?? this.documentBytes),
      documentName: clearDocument ? null : (documentName ?? this.documentName),
      documentSize: clearDocument ? null : (documentSize ?? this.documentSize),
      documentError: clearDocumentError
          ? null
          : (documentError ?? this.documentError),
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      submitError:
          clearSubmitError ? null : (submitError ?? this.submitError),
      registrationResponse: clearRegistrationResponse
          ? null
          : (registrationResponse ?? this.registrationResponse),
    );
  }
}
