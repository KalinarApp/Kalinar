import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'sign_in_desktop.dart';
import 'sign_in_mobile.dart';

class SignInScreen extends ConsumerWidget {
  static const String route = "/login";

  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(.9),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(height: 128, "assets/app_icon/icon.png"),
              ),
              Text(AppLocalizations.of(context)!.applicationTitle, style: Theme.of(context).textTheme.headline3),
              const SizedBox(height: 10),
              Text(AppLocalizations.of(context)!.applicationSubtitle, style: Theme.of(context).textTheme.subtitle1),
              const SizedBox(height: 20),
              Text(AppLocalizations.of(context)!.loginDescription, style: Theme.of(context).textTheme.bodyLarge, textAlign: TextAlign.center),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * .95,
                child: Platform.isAndroid || Platform.isIOS ? const SignInMobile() : const SignInDesktop(),
              ),
            ],
          ),
        ));
  }
}
