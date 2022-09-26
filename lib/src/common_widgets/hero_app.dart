import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hero/src/common_widgets/welcome_screen.dart';
import 'package:hero/src/features/authentication/presentation/auth_controller.dart';
import 'package:hero/src/features/authentication/presentation/init_controller.dart';
import 'package:hero/src/features/skilling/presentation/abilities/edit_ability/edit_ability_screen.dart';
import 'package:hero/src/features/skilling/presentation/skills/edit_skill/mobile/mobile_edit_skill_screen.dart';
import 'package:hero/src/features/skilling/presentation/skills/list_skills/skill_list.dart';

import '../features/skilling/presentation/abilities/ability_list.dart';

class HeroApp extends ConsumerWidget {
  const HeroApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(initControllerProvider.notifier).initialize();

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
      // home: Platform.isAndroid || Platform.isIOS ? const MobileEditSkillScreen() : const DesktopEditSkillScreen(),
      home: const WelcomeScreen(),
      routes: {
        SkillList.routeName: (_) => const SkillList(),
        AbilityList.routeName: (_) => const AbilityList(),
        MobileEditSkillScreen.routeName: (_) => const MobileEditSkillScreen(),
        EditAbilityScreen.routeName: (_) => const EditAbilityScreen(),
      },
    );
  }
}
