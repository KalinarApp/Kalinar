import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalinar/src/utils/local_storage/shared_preferences_helper.dart';
import 'package:kalinar/src/utils/local_storage/storage_key.dart';

import '../../../common_widgets/spinner.dart';
import '../../../routing/app_route.dart';
import '../../../utils/http/error_response.dart';
import '../../user_management/data/user_repository.dart';

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(getUserGroupsByIdProvider);
    final user = ref.watch(getUserByIdProvider);

    ref.listen(getUserByIdProvider, (old, user) {
      if ((old?.hasError ?? false) && user.hasError) return;
      if (user.hasError && user.error is ErrorResponse && (user.error as ErrorResponse).type == userNotFoundException) {
        context.pushNamed(AppRoute.userProfileEdit.name);
      }
    });

    ref.listen(getSelectedGroupProvider, (_, group) {
      if (group.hasValue && group.value == null) {
        ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          content: Text(AppLocalizations.of(context)!.groupNotInGroupText(user.value!.username)),
          actions: [
            TextButton(onPressed: () {}, child: const Text("Erstellen")),
            TextButton(onPressed: () {}, child: const Text("Beitreten")),
          ],
        ));
      }
    });

    ref.listen(getUserGroupsByIdProvider, (_, groups) {
      if (groups.isLoading) return;
      if (!groups.hasValue) return;
      if (groups.value!.isEmpty) {
        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showMaterialBanner(MaterialBanner(
            content: Text(AppLocalizations.of(context)!.groupNotInGroupText(user.value!.username)),
            actions: [
              TextButton(onPressed: () => context.pushNamed(AppRoute.groupCreate.name), child: Text(AppLocalizations.of(context)!.groupCreateAction)),
              TextButton(onPressed: () {}, child: Text(AppLocalizations.of(context)!.groupJoinAction)),
            ],
          ));
      } else if (groups.value!.length > 1) {
        ScaffoldMessenger.of(context)
          ..hideCurrentMaterialBanner()
          ..showMaterialBanner(MaterialBanner(
            content: Text(AppLocalizations.of(context)!.groupSelectDefaultTitle),
            actions: [
              TextButton(onPressed: () {}, child: Text(AppLocalizations.of(context)!.groupSelectDefaultAction)),
            ],
          ));
      } else {
        ScaffoldMessenger.of(context).clearMaterialBanners();
        ref.read(getSharedPreferencesProvider).setString(StorageKey.defaultGroupId, groups.value!.first.group.id);
      }
    });

    return user.isLoading
        ? const Spinner()
        : Center(child: Text("Hallo ${user.hasValue ? user.value!.username : "Nutzer"}, hier könnte deine Werbung stehen!"));
  }
}
