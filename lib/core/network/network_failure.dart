import 'package:freezed_annotation/freezed_annotation.dart';
part 'network_failure.freezed.dart';

@freezed
class NetworkFailure with _$NetworkFailure {
  const factory NetworkFailure.serverError(dynamic message) = ServerFailure;
  const factory NetworkFailure.timeout() = TimeoutFailure;
  const factory NetworkFailure.noInternet() = NoInternetFailure;
  const factory NetworkFailure.unauthorized() = UnauthorizedFailure;
  const factory NetworkFailure.notFound() = NotFoundFailure;
  const factory NetworkFailure.unknown(String message) = UnknownFailure;
}
