import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:suatina_web_project/core/constants/api_constants.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
}
