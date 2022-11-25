import 'package:flutter/cupertino.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_error.freezed.dart';

@freezed
class APIError with _$APIError {
  const factory APIError.unauthorized() = _unauthorized;
  const factory APIError.forbidden() = _forbidden;
  const factory APIError.badRequest(String errorId, String errorMessage) = _BadRequest;
  const factory APIError.notFound(String errorId, String errorMessage) = _NotFound;
  const factory APIError.problem(String errorId, String errorMessage) = _problem;
  const factory APIError.unknown(String errorId, String errorMessage) = _Unknown;
  const factory APIError.noInternetConnection() = _NoInternetConnection;
}

extension APIErrorExtension on APIError {
  String getMessage(BuildContext context) {
    switch (runtimeType) {
      case _NoInternetConnection:
        return AppLocalizations.of(context)!.errorNoInternetConnection;
      case _unauthorized:
        return AppLocalizations.of(context)!.errorUnauthorized;
      case _forbidden:
        return AppLocalizations.of(context)!.errorForbidden;
      default:
        return AppLocalizations.of(context)!.errorUnknown;
    }
  }
}
