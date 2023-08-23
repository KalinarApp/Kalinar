import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common_widgets/spinner.dart';
import '../../../routing/app_route.dart';
import '../../../utils/async_value_extension.dart';
import '../../../utils/http/error_response.dart';
import '../../user_management/data/user_repository.dart';

class HomeContent extends ConsumerWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(getUserByIdProvider);
    // final group = ref.watch(getSelectedGroupProvider);

    ref.listen(getUserByIdProvider, (old, user) {
      user.showNotification(context);
      if ((old?.hasError ?? false) && user.hasError) return;
      if (user.hasError && user.error is ErrorResponse && (user.error as ErrorResponse).type == userNotFoundException) {
        context.pushNamed(AppRoute.createProfile.name);
      }
    });

    ref.listen(getSelectedGroupProvider, (_, group) {
      if (group.hasValue) {
        ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
          content: Text(AppLocalizations.of(context)!.groupNotInGroupText(user.value!.username)),
          actions: [
            TextButton(onPressed: () {}, child: const Text("Erstellen")),
            TextButton(onPressed: () {}, child: const Text("Beitreten")),
          ],
        ));
      }
    });

    return user.isLoading
        ? const Spinner()
        : Center(child: Text("Hallo ${user.hasValue ? user.value!.username : "Nutzer"}, hier könnte deine Werbung stehen!"));
    ;
  }
}
