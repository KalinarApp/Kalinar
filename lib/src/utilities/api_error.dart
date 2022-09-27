import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';

@freezed
class APIError with _$APIError {
  const factory APIError.unauthorizedKey() = _InvalidApiKey;
  const factory APIError.noInternetConnection() = _NoInternetConnection;
  const factory APIError.notFound() = _NotFound;
  const factory APIError.unknown() = _Unknown;
}

extension ErrorAsync on APIError {
  AsyncValue<T> asAsyncValue<T>() => when(
        unauthorizedKey: () => const AsyncValue.error('Invalid API key'),
        noInternetConnection: () => const AsyncValue.error('No Internet connection'),
        notFound: () => const AsyncValue.error('City not found'),
        unknown: () => const AsyncValue.error('Some error occurred'),
      );
}
