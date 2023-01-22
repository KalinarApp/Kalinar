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
    if (this is _NoInternetConnection) {
      return AppLocalizations.of(context)!.errorNoInternetConnection;
    } else if (this is _unauthorized) {
      return AppLocalizations.of(context)!.errorUnauthorized;
    } else if (this is _forbidden) {
      return AppLocalizations.of(context)!.errorForbidden;
    } else if (this is _problem) {
      String message;
      final error = this as _problem;
      switch (error.errorId) {
        case "NodeNotUnlockableException":
          message = AppLocalizations.of(context)!.errorNodeNotUnlockable;
          break;
        case "NotEnoughSkillpointsException":
          message = AppLocalizations.of(context)!.errorNotEnoughSkillpoints;
          break;
        default:
          message = AppLocalizations.of(context)!.errorUnknown;
          break;
      }
      return message;
    }
    return AppLocalizations.of(context)!.errorUnknown;
  }
}
