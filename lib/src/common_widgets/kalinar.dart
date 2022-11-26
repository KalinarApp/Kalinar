import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/localization/l10n.dart';

import '../features/authentication/application/init_controller.dart';
import '../utilities/router/routes.dart';

class Kalinar extends ConsumerStatefulWidget {
  const Kalinar({super.key});

  @override
  ConsumerState<Kalinar> createState() => _KalinarState();
}

class _KalinarState extends ConsumerState<Kalinar> {
  @override
  void didChangeDependencies() {
    ref.read(initControllerProvider).initialize();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        onGenerateTitle: (ctx) => AppLocalizations.of(ctx)!.applicationTitle,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        supportedLocales: const [Locale("de"), Locale("en")],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          FormBuilderLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        routerConfig: getRouter(ref));
  }
}