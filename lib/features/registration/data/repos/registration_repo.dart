import 'package:dio/dio.dart';
import 'package:suatina_web_project/core/network/api_client.dart';
import 'package:suatina_web_project/core/network/api_handler.dart';
import 'package:suatina_web_project/core/network/api_result.dart';
import 'package:suatina_web_project/features/registration/data/models/classification_models.dart';
import 'package:suatina_web_project/features/registration/data/models/registration_response_model.dart';

class RegistrationRepo {
  final ApiClient apiClient;
  final ApiHandler apiHandler;

  const RegistrationRepo({
    required this.apiClient,
    required this.apiHandler,
  });

  Future<ApiResult<List<SectorModel>>> getSectors() {
    return apiHandler.makeRequest(() => apiClient.getSectors());
  }

  Future<ApiResult<List<IndustryModel>>> getIndustries(String sectorId) {
    return apiHandler.makeRequest(() => apiClient.getIndustries(sectorId));
  }

  Future<ApiResult<List<SubIndustryModel>>> getSubIndustries(String industryId) {
    return apiHandler
        .makeRequest(() => apiClient.getSubIndustries(industryId));
  }

  Future<ApiResult<RegistrationResponseModel>> registerOrganization(
    FormData formData,
  ) {
    return apiHandler
        .makeRequest(() => apiClient.registerOrganization(formData));
  }
}
