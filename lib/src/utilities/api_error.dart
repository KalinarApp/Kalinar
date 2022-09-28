import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';

@freezed
class APIError with _$APIError {
  const factory APIError.unauthorized() = _unauthorized;
  const factory APIError.noInternetConnection() = _NoInternetConnection;
  const factory APIError.notFound() = _NotFound;
  const factory APIError.groupAlreadyExist() = _GroupAlreadyExist;
  const factory APIError.unknown() = _Unknown;
}

extension ErrorAsync on APIError {
  AsyncValue<T> asAsyncValue<T>() => when(
        unauthorized: () => const AsyncValue.error('You are not authorized'),
        noInternetConnection: () => const AsyncValue.error('No Internet connection'),
        notFound: () => const AsyncValue.error('City not found'),
        groupAlreadyExist: () => const AsyncValue.error("The group you want to create already exists."),
        unknown: () => const AsyncValue.error('Some error occurred'),
      );
}
