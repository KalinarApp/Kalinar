import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hero/src/features/skilling/presentation/edit_skill/desktop/desktop_edit_skill_screen.dart';

import '../features/skilling/presentation/edit_skill/mobile/mobile_edit_skill_screen.dart';

class HeroApp extends StatelessWidget {
  const HeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: Platform.isAndroid || Platform.isIOS ? const MobileEditSkillScreen() : const DesktopEditSkillScreen(),
    );
  }
}
