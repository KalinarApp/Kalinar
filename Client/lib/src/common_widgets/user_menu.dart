// ignore_for_file: use_build_context_synchronously

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utilities/constants.dart';

class UserMenu extends ConsumerWidget {
  const UserMenu({Key? key}) : super(key: key);

  Future<void> _openPrivacy(BuildContext ctx) async {
    if (!await launchUrl(Uri.parse(Constants.privacyUrl), mode: LaunchMode.inAppWebView)) {
      if (!ctx.mounted) return;
      throw AppLocalizations.of(ctx)!.openProfileFailed;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (null == currentUser) return Container();

    final gravater = Gravatar(currentUser.email!);

    return CustomPopupMenu(
      menuBuilder: () => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Theme.of(context).dialogBackgroundColor,
          child: IntrinsicWidth(
            child: Column(
              children: [
                InkWell(
                    onTap: () => GoRouter.of(context).pushNamed("profile"), child: ListTile(title: Text(AppLocalizations.of(context)!.openProfile))),
                InkWell(onTap: () async => await _openPrivacy(context), child: ListTile(title: Text(AppLocalizations.of(context)!.privacyPolicy))),
                const Divider(),
                InkWell(onTap: () => FirebaseAuth.instance.signOut(), child: ListTile(title: Text(AppLocalizations.of(context)!.logout))),
              ],
            ),
          ),
        ),
      ),
      pressType: PressType.singleClick,
      arrowColor: Theme.of(context).dialogBackgroundColor,
      child: Center(
        child: CircleAvatar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          backgroundImage: NetworkImage(gravater.imageUrl()),
        ),
      ),
    );
  }
}
