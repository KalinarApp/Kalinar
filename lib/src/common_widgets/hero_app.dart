import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:hero/src/features/skilling/presentation/abilities/edit_ability/edit_ability_screen.dart';

import '../features/authentication/data/auth_repository.dart';
import '../features/authentication/presentation/auth/init_controller.dart';
import '../features/home/presentation/home_screen_selector.dart';
import '../features/skilling/presentation/abilities/ability_list.dart';
import '../features/skilling/presentation/abilities/edit_ability/create_ability_screen.dart';
import '../features/skilling/presentation/skills/edit_skill/mobile/mobile_edit_skill_screen.dart';
import '../features/skilling/presentation/skills/list_skills/skill_list.dart';

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
    final authState = ref.watch(authChangedProvider);

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
      home: HomeScreenSelector.getHomeScreen(authState.value),
    );
  }
}
