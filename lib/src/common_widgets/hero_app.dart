import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:hero/src/utilities/router/routes.dart';

import '../features/authentication/application/init_controller.dart';

class HeroApp extends ConsumerStatefulWidget {
  const HeroApp({super.key});

  @override
  ConsumerState<HeroApp> createState() => _HeroAppState();
}

class _HeroAppState extends ConsumerState<HeroApp> {
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
