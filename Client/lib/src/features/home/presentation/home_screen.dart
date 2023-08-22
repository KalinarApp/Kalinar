import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common_widgets/layout/size.dart';
import '../../../common_widgets/user_menu.dart';
import '../../../routing/app_route.dart';
import '../../../utils/http/error_response.dart';
import '../../user_management/data/user_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(getUserByIdProvider);
    final groups = ref.watch(getUserGroupsByIdProvider);

    ref.listen(getUserByIdProvider, (old, user) {
      if ((old?.hasError ?? false) && user.hasError) return;
      if (user.hasError && user.error is ErrorResponse && (user.error as ErrorResponse).type == userNotFoundException) {
        context.pushNamed(AppRoute.createProfile.name);
      }
    });

    ref.listen(getUserGroupsByIdProvider, (previous, next) {
      if (next.hasValue && next.value!.isEmpty) {
        // TODO: show material banner for creating or join a group
      } else if (next.value!.length > 1) {
        // TODO: show material banner to select a default group
      } else if (next.value!.length == 1) {
        // TODO: set default group
      }
    });

    return LayoutBuilder(
      builder: (ctx, constraints) => Scaffold(
        appBar: isMobile(constraints) ? AppBar(actions: const [Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu())]) : null,
        body: Center(child: Text("Hallo ${user.hasValue ? user.value!.username : "Nutzer"}, hier könnte deine Werbung stehen!")),
      ),
    );
  }
}
