// ignore_for_file: use_build_context_synchronously

import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../routing/app_route.dart';
import '../../../../utils/build_context_extensions.dart';
import '../../../../utils/constants.dart';
import '../../data/user_repository.dart';
import 'user_avatar.dart';

class UserMenu extends ConsumerWidget {
  const UserMenu({Key? key}) : super(key: key);

  Future<void> _openPrivacy(BuildContext ctx) async {
    if (!await launchUrl(Uri.parse(Constants.privacyUrl), mode: LaunchMode.inAppWebView)) {
      if (!ctx.mounted) return;
      throw ctx.localizations.openProfileFailed;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(getCurrentUserProvider);

    final avatar = Center(child: UserAvatar(imageUrl: currentUser.hasValue ? currentUser.value!.imageUrl : null));

    return !currentUser.hasValue
        ? avatar
        : CustomPopupMenu(
            menuBuilder: () => ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
                color: context.theme.dialogBackgroundColor,
                child: IntrinsicWidth(
                  child: Column(
                    children: [
                      InkWell(
                          onTap: () => context.pushNamed(AppRoute.userProfile.name, extra: currentUser.value!),
                          child: ListTile(title: Text(context.localizations.userEditTitle))),
                      InkWell(onTap: () async => await _openPrivacy(context), child: ListTile(title: Text(context.localizations.privacyPolicy))),
                      const Divider(),
                      InkWell(onTap: () => FirebaseAuth.instance.signOut(), child: ListTile(title: Text(context.localizations.logout))),
                    ],
                  ),
                ),
              ),
            ),
            pressType: PressType.singleClick,
            arrowColor: context.theme.dialogBackgroundColor,
            child: avatar,
          );
  }
}
