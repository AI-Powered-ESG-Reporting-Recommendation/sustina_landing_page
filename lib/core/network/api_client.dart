import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:suatina_web_project/core/constants/api_constants.dart';
import 'package:suatina_web_project/features/registration/data/models/classification_models.dart';
import 'package:suatina_web_project/features/registration/data/models/registration_response_model.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('sectors')
  Future<List<SectorModel>> getSectors();

  @GET('sectors/{sectorId}/industries')
  Future<List<IndustryModel>> getIndustries(
    @Path('sectorId') String sectorId,
  );

  @GET('industries/{industryId}/sub-industries')
  Future<List<SubIndustryModel>> getSubIndustries(
    @Path('industryId') String industryId,
  );

  @POST('registration/organizations')
  Future<RegistrationResponseModel> registerOrganization(
    @Body() FormData formData,
  );
}
