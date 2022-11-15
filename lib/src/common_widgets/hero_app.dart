import 'package:flutter/material.dart';
import 'package:flutter_auth/models/user_info.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:go_router/go_router.dart';
import 'package:hero/src/utilities/router/routes.dart';

import '../features/authentication/domain/user_info_extensions.dart';
import '../features/admin/common/presentation/admin_menu_screen.dart';
import '../features/authentication/application/init_controller.dart';
import '../features/authentication/data/auth_repository.dart';
import '../features/authentication/presentation/sign_in_screen.dart';
import '../features/group_management/application/has_group_controller.dart';
import '../features/group_management/presentation/group_screen.dart';
import '../features/group_management/presentation/user_invite_screen.dart';
import '../features/home/presentation/home_screen.dart';
import '../features/home/presentation/welcome_screen.dart';
import '../utilities/router/admin_routes.dart';
import 'navigation/scaffold_with_bottom_navbar.dart';
import 'navigation/scaffold_with_navbar_item.dart';

class HeroApp extends ConsumerStatefulWidget {
  const HeroApp({super.key});

  @override
  ConsumerState<HeroApp> createState() => _HeroAppState();
}

class _HeroAppState extends ConsumerState<HeroApp> {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final shellNavigatorKey = GlobalKey<NavigatorState>();

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
        routerConfig: getRouter(ref, rootNavigatorKey, shellNavigatorKey));
  }
}
