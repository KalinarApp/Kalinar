import 'dart:math';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalinar/src/utils/http/error_response.dart';

import 'api_error.dart';

extension AsyncValueUI on AsyncValue {
  void showSnackbarOnError(BuildContext context) {
    if (!isRefreshing && hasError) {
      String message = AppLocalizations.of(context)!.errorUnknown;

      if (error is APIError) {
        message = (error as APIError).getMessage(context);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  void showNotification(BuildContext context, {String? successMessage, String? customErrorMessage}) {
    if (isLoading) return;
    if (hasError && error is ErrorResponse) {
      final errorResponse = error as ErrorResponse;
      final errorMessage = customErrorMessage ?? errorResponse.getLocalizedMessage(context);

      ElegantNotification.error(
        notificationPosition: kIsWeb ? NotificationPosition.bottomRight : NotificationPosition.topRight,
        toastDuration: const Duration(seconds: 5),
        height: min(50, MediaQuery.of(context).size.height * .12),
        width: min(500, MediaQuery.of(context).size.width * .7),
        description: Text(errorMessage),
        background: Theme.of(context).colorScheme.background,
      ).show(context);
    } else if (successMessage != null && hasValue) {
      ElegantNotification.success(
        notificationPosition: kIsWeb ? NotificationPosition.bottomRight : NotificationPosition.topRight,
        toastDuration: const Duration(seconds: 5),
        height: min(50, MediaQuery.of(context).size.height * .12),
        width: min(500, MediaQuery.of(context).size.width * .7),
        background: Theme.of(context).colorScheme.background,
        description: Text(successMessage),
      ).show(context);
    }
  }
}
