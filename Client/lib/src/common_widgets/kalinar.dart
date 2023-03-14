import 'dart:io';

import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:store_checker/store_checker.dart';

import '../utilities/router/routes.dart';

class Kalinar extends ConsumerStatefulWidget {
  const Kalinar({super.key});

  @override
  ConsumerState<Kalinar> createState() => _KalinarState();
}

class _KalinarState extends ConsumerState<Kalinar> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _checkForUpdate() async {
    if (Platform.isAndroid && await StoreChecker.getSource == Source.IS_INSTALLED_FROM_PLAY_STORE) {
      final updateAvailable = await InAppUpdate.checkForUpdate();
      if (updateAvailable.updateAvailability == UpdateAvailability.updateAvailable) {
        if (updateAvailable.immediateUpdateAllowed) {
          await InAppUpdate.performImmediateUpdate();
        } else if (updateAvailable.flexibleUpdateAllowed && await InAppUpdate.startFlexibleUpdate() == AppUpdateResult.success) {
          await InAppUpdate.completeFlexibleUpdate();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkForUpdate();

    return MaterialApp.router(
        builder: (context, child) => MediaQuery(
            // Temporary fix for https://github.com/AbdulRahmanAlHamali/flutter_typeahead/issues/463
            data: MediaQuery.of(context).copyWith(accessibleNavigation: false),
            child: child!),
        onGenerateTitle: (ctx) => AppLocalizations.of(ctx)!.applicationTitle,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        supportedLocales: const [Locale("de"), Locale("en")],
        localizationsDelegates: [
          AppLocalizations.delegate,
          FormBuilderLocalizations.delegate,
          FirebaseUILocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        routerConfig: ref.watch(routeProvider));
  }
}
