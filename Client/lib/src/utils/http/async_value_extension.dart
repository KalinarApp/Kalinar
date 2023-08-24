import 'dart:math';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalinar/src/utils/http/error_response.dart';

extension AsyncValueUI on AsyncValue {
  void showNotification(BuildContext context, {String? successMessage, String? customErrorMessage}) {
    if (isLoading) return;
    if (hasError) {
      String errorMessage = "";
      if (error is ErrorResponse) {
        final errorResponse = error as ErrorResponse;
        errorMessage = customErrorMessage ?? errorResponse.getLocalizedMessage(context);
      } else {
        errorMessage = customErrorMessage ?? AppLocalizations.of(context)!.errorUnknown;
      }

      ElegantNotification.error(
        notificationPosition: kIsWeb ? NotificationPosition.bottomRight : NotificationPosition.topRight,
        toastDuration: const Duration(seconds: 10),
        height: min(50, MediaQuery.of(context).size.height * .12),
        width: min(500, MediaQuery.of(context).size.width * .7),
        description: Text(errorMessage),
        background: Theme.of(context).colorScheme.background,
        progressIndicatorBackground: Theme.of(context).colorScheme.surface,
      ).show(context);
    } else if (successMessage != null && hasValue) {
      ElegantNotification.success(
        notificationPosition: kIsWeb ? NotificationPosition.bottomRight : NotificationPosition.topRight,
        toastDuration: const Duration(seconds: 3),
        height: min(50, MediaQuery.of(context).size.height * .12),
        width: min(500, MediaQuery.of(context).size.width * .7),
        background: Theme.of(context).colorScheme.background,
        progressIndicatorBackground: Theme.of(context).colorScheme.surface,
        description: Text(successMessage),
      ).show(context);
    }
  }
}
