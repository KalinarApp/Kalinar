import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common_widgets/spinner.dart';
import '../../../routing/app_route.dart';
import '../../../utils/http/error_response.dart';
import '../../user_management/data/user_repository.dart';

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(getUserByIdProvider);

    ref.listen(getUserByIdProvider, (old, user) {
      if ((old?.hasError ?? false) && user.hasError) return;
      if (user.hasError && user.error is ErrorResponse && (user.error as ErrorResponse).type == userNotFoundException) {
        context.pushNamed(AppRoute.createProfile.name);
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
        ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          content: Text(AppLocalizations.of(context)!.groupNotInGroupText(user.value!.username)),
          actions: [
            TextButton(onPressed: () {}, child: const Text("Erstellen")),
            TextButton(onPressed: () {}, child: const Text("Beitreten")),
          ],
        ));
      } else if (groups.value!.length > 1) {
        ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          content: const Text(
              "Du bist Mitglied in mehreren Gruppen. Bitte wähle für die weitere Nutzung der App eine Gruppe aus.\nDiese kannst du zu jeder Zeit in deinem Benutzerprofil wechseln."),
          actions: [
            TextButton(onPressed: () {}, child: const Text("Gruppe auswählen")),
          ],
        ));
      } else {
        // TODO: Set group as default group.
      }
    });

    return user.isLoading
        ? const Spinner()
        : Center(child: Text("Hallo ${user.hasValue ? user.value!.username : "Nutzer"}, hier könnte deine Werbung stehen!"));
  }
}
