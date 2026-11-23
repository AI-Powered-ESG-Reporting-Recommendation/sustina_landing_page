import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suatina_web_project/core/network/api_result.dart';
import 'package:suatina_web_project/core/network/network_failure.dart';
import 'package:suatina_web_project/features/registration/data/repos/registration_repo.dart';
import 'package:suatina_web_project/features/registration/logic/registration_state.dart';

class RegistrationCubit extends Cubit<RegistrationState> {
  final RegistrationRepo repo;

  RegistrationCubit({required this.repo})
      : super(const RegistrationState()) {
    loadSectors();
  }

  // Race condition sequence counters
  int _sectorLoadSeq = 0;
  int _industryLoadSeq = 0;
  int _subIndustryLoadSeq = 0;

  Future<void> loadSectors() async {
    final seq = ++_sectorLoadSeq;
    emit(state.copyWith(
      isSectorsLoading: true,
      clearSectorsError: true,
    ));

    final result = await repo.getSectors();
    if (seq != _sectorLoadSeq) return; // Stale request

    result.when(
      success: (sectors) {
        emit(state.copyWith(
          isSectorsLoading: false,
          sectors: sectors,
          clearSectorsError: true,
        ));
      },
      failure: (failure) {
        emit(state.copyWith(
          isSectorsLoading: false,
          sectorsError: _mapFailureMessage(failure),
        ));
      },
    );
  }

  Future<void> selectSector(String? sectorId) async {
    if (sectorId == state.selectedSectorId) return;

    if (sectorId == null || sectorId.isEmpty) {
      _industryLoadSeq++;
      _subIndustryLoadSeq++;
      emit(state.copyWith(
        clearSelectedSector: true,
        clearSelectedIndustry: true,
        clearSelectedSubIndustry: true,
        industries: const [],
        subIndustries: const [],
        isIndustriesLoading: false,
        isSubIndustriesLoading: false,
        clearIndustriesError: true,
        clearSubIndustriesError: true,
      ));
      return;
    }

    final seq = ++_industryLoadSeq;
    _subIndustryLoadSeq++;

    // Clear dependent selections immediately and start loading industries
    emit(state.copyWith(
      selectedSectorId: sectorId,
      clearSelectedIndustry: true,
      clearSelectedSubIndustry: true,
      industries: const [],
      subIndustries: const [],
      isIndustriesLoading: true,
      clearIndustriesError: true,
      clearSubIndustriesError: true,
    ));

    final result = await repo.getIndustries(sectorId);
    if (seq != _industryLoadSeq) return; // Stale request

    result.when(
      success: (industries) {
        emit(state.copyWith(
          isIndustriesLoading: false,
          industries: industries,
          clearIndustriesError: true,
        ));
      },
      failure: (failure) {
        emit(state.copyWith(
          isIndustriesLoading: false,
          industriesError: _mapFailureMessage(failure),
        ));
      },
    );
  }

  Future<void> selectIndustry(String? industryId) async {
    if (industryId == state.selectedIndustryId) return;

    if (industryId == null || industryId.isEmpty) {
      _subIndustryLoadSeq++;
      emit(state.copyWith(
        clearSelectedIndustry: true,
        clearSelectedSubIndustry: true,
        subIndustries: const [],
        isSubIndustriesLoading: false,
        clearSubIndustriesError: true,
      ));
      return;
    }

    final seq = ++_subIndustryLoadSeq;

    // Clear dependent sub-industry selection and start loading sub-industries
    emit(state.copyWith(
      selectedIndustryId: industryId,
      clearSelectedSubIndustry: true,
      subIndustries: const [],
      isSubIndustriesLoading: true,
      clearSubIndustriesError: true,
    ));

    final result = await repo.getSubIndustries(industryId);
    if (seq != _subIndustryLoadSeq) return; // Stale request

    result.when(
      success: (subIndustries) {
        emit(state.copyWith(
          isSubIndustriesLoading: false,
          subIndustries: subIndustries,
          clearSubIndustriesError: true,
        ));
      },
      failure: (failure) {
        emit(state.copyWith(
          isSubIndustriesLoading: false,
          subIndustriesError: _mapFailureMessage(failure),
        ));
      },
    );
  }

  void selectSubIndustry(String? subIndustryId) {
    if (subIndustryId == null || subIndustryId.isEmpty) {
      emit(state.copyWith(clearSelectedSubIndustry: true));
    } else {
      emit(state.copyWith(
        selectedSubIndustryId: subIndustryId,
        clearSubIndustriesError: true,
      ));
    }
  }

  void setDocument({
    required Uint8List bytes,
    required String name,
    required int size,
  }) {
    final lower = name.toLowerCase();
    if (!lower.endsWith('.pdf')) {
      emit(state.copyWith(
        documentError: 'Only PDF documents are accepted (.pdf)',
      ));
      return;
    }

    emit(state.copyWith(
      documentBytes: bytes,
      documentName: name,
      documentSize: size,
      clearDocumentError: true,
    ));
  }

  void clearDocument() {
    emit(state.copyWith(
      clearDocument: true,
      clearDocumentError: true,
    ));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(
      isConfirmPasswordVisible: !state.isConfirmPasswordVisible,
    ));
  }

  void setTermsAccepted(bool accepted) {
    emit(state.copyWith(termsAccepted: accepted));
  }

  Future<bool> submitRegistration({
    required String legalName,
    required String hqCountry,
    required String firstReportingYear,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    // Client side pre-checks
    if (state.selectedSubIndustryId == null ||
        state.selectedSubIndustryId!.isEmpty) {
      emit(state.copyWith(
        submitError: 'Please select a Sub-Industry to complete classification',
      ));
      return false;
    }

    if (state.documentBytes == null || state.documentBytes!.isEmpty) {
      emit(state.copyWith(
        submitError: 'Please upload an official PDF verification document',
        documentError: 'Verification document is required',
      ));
      return false;
    }

    if (!state.termsAccepted) {
      emit(state.copyWith(
        submitError: 'You must accept the terms and conditions to proceed',
      ));
      return false;
    }

    emit(state.copyWith(
      isSubmitting: true,
      clearSubmitError: true,
    ));

    try {
      final formData = FormData.fromMap({
        'legalName': legalName.trim(),
        'hqCountry': hqCountry.trim(),
        'firstReportingYear': firstReportingYear.trim(),
        'subIndustryId': state.selectedSubIndustryId!,
        'email': email.trim(),
        'password': password,
        'confirmPassword': confirmPassword,
        'termsAccepted': 'true',
        'verificationDocument': MultipartFile.fromBytes(
          state.documentBytes!,
          filename: state.documentName ?? 'verification_document.pdf',
        ),
      });

      final result = await repo.registerOrganization(formData);

      return await result.when(
        success: (response) {
          emit(state.copyWith(
            isSubmitting: false,
            registrationResponse: response,
            clearSubmitError: true,
          ));
          return true;
        },
        failure: (failure) {
          final errorMsg = _mapFailureMessage(failure);
          emit(state.copyWith(
            isSubmitting: false,
            submitError: errorMsg,
          ));
          return false;
        },
      );
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        submitError: e.toString(),
      ));
      return false;
    }
  }

  void reset() {
    emit(const RegistrationState());
    loadSectors();
  }

  String _mapFailureMessage(NetworkFailure failure) {
    return failure.when(
      serverError: (dynamic msg) {
        if (msg is List) {
          return msg.map((e) => e.toString()).join('\n');
        }
        return msg?.toString() ?? 'Server returned an error';
      },
      timeout: () => 'Connection timed out. Please check your internet connection.',
      noInternet: () => 'No internet connection detected.',
      unauthorized: () => 'Unauthorized. Please check your access credentials.',
      notFound: () => 'Requested resource not found on server.',
      unknown: (msg) => msg.isNotEmpty ? msg : 'An unexpected error occurred.',
    );
  }
}
