import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/authentication/data/auth_repository.dart';
import 'package:hero/src/features/authentication/application/auth_controller.dart';
import 'package:hero/src/utilities/router/routes.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utilities/constants.dart';

class UserMenu extends ConsumerWidget {
  const UserMenu({Key? key}) : super(key: key);

  Future<void> _openPrivacy() async {
    if (!await launchUrl(Uri.parse(Constants.privacyUrl), mode: LaunchMode.inAppWebView)) {
      throw 'Could not open profile.';
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
                // InkWell(onTap: () {}, child: const ListTile(title: Text("Einstellungen"))),
                // const Divider(),
                InkWell(onTap: () => ref.read(authProvider).openProfile(), child: const ListTile(title: Text("Profil ansehen"))),
                InkWell(onTap: () async => await _openPrivacy(), child: const ListTile(title: Text("Datenschutzerklärung"))),
                const Divider(),
                InkWell(onTap: () => ref.read(authControllerProvider.notifier).signOut(), child: const ListTile(title: Text("Abmelden"))),
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
