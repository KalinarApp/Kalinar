import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeMessage extends StatelessWidget {
  final String username;

  const WelcomeMessage({required this.username, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Card(
        elevation: 4,
        color: Theme.of(context).primaryColor,
        margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: ListTile(title: Text(AppLocalizations.of(context)!.welcomeMessage(username))),
      ),
    );
  }
}
