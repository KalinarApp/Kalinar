import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';

@freezed
class APIError with _$APIError {
  const factory APIError.unauthorized() = _unauthorized;
  const factory APIError.noInternetConnection() = _NoInternetConnection;
  const factory APIError.badRequest() = _BadRequest;
  const factory APIError.notFound() = _NotFound;
  const factory APIError.unknown() = _Unknown;
}
