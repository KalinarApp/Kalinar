import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:kalinar/src/routing/app_router.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:store_checker/store_checker.dart';

import 'common_widgets/messages/message_type.dart';
import 'common_widgets/messages/welcome_message.dart';
import 'features/group_management/data/user_repository.dart';

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
  void initState() {
    FirebaseMessaging.onMessage.listen((message) {
      if (null == message.notification) {
        if (message.data.containsKey("type")) {
          Widget widget;
          MessageType type = MessageType.values.byName(message.data["type"]);

          switch (type) {
            case MessageType.welcome:
              widget = WelcomeMessage(username: message.data["user"]);
              break;
          }

          showOverlayNotification((context) => widget, duration: const Duration(seconds: 5));
        }
      }
    });

    Future.delayed(Duration.zero, () async {
      String? token = await FirebaseMessaging.instance.getToken();

      if (null != token) {
        ref.read(userRepositoryProvider).updateDeviceId(token);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _checkForUpdate();

    final router = ref.watch(goRouterProvider);
    return OverlaySupport.global(
      child: MaterialApp.router(
        routerConfig: router,
        builder: (context, child) => MediaQuery(
            // Temporary fix for https://github.com/AbdulRahmanAlHamali/flutter_typeahead/issues/463
            data: MediaQuery.of(context).copyWith(accessibleNavigation: false),
            child: child!),
        onGenerateTitle: (ctx) => AppLocalizations.of(ctx)!.applicationTitle,
        theme: ThemeData.light(useMaterial3: false),
        darkTheme: ThemeData.dark(useMaterial3: false),
        debugShowCheckedModeBanner: false,
        supportedLocales: const [Locale("de"), Locale("en")],
        localizationsDelegates: [
          AppLocalizations.delegate,
          FormBuilderLocalizations.delegate,
          FirebaseUILocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
      ),
    );
  }
}
