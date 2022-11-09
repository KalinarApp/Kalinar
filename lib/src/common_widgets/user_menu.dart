import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/authentication/data/auth_repository.dart';
import 'package:hero/src/features/authentication/application/auth_controller.dart';
import 'package:hero/src/utilities/router/routes.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../utilities/constants.dart';

class UserMenu extends ConsumerWidget {
  const UserMenu({Key? key}) : super(key: key);

  Future<void> _openPrivacy(BuildContext ctx) async {
    if (!await launchUrl(Uri.parse(Constants.privacyUrl), mode: LaunchMode.inAppWebView)) {
      throw AppLocalizations.of(ctx)!.openProfileFailed;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userChangedProvider);

    final gravater = Gravatar(currentUser!.email);

    return CustomPopupMenu(
      menuBuilder: () => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Theme.of(context).dialogBackgroundColor,
          child: IntrinsicWidth(
            child: Column(
              children: [
                InkWell(onTap: () => ref.read(authProvider).openProfile(), child: ListTile(title: Text(AppLocalizations.of(context)!.openProfile))),
                InkWell(onTap: () async => await _openPrivacy(context), child: ListTile(title: Text(AppLocalizations.of(context)!.privacyPolicy))),
                const Divider(),
                InkWell(
                    onTap: () => ref.read(authControllerProvider.notifier).signOut(),
                    child: ListTile(title: Text(AppLocalizations.of(context)!.login))),
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
