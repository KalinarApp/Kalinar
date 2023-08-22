import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common_widgets/layout/size.dart';
import '../../../common_widgets/user_menu.dart';
import '../../../routing/app_route.dart';
import '../../../utils/http/error_response.dart';
import '../../authentication/data/firebase_auth_repository.dart';
import '../../user_management/data/user_repository.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(firebaseAuthProvider).currentUser!.uid;
    final user = ref.watch(getUserByIdProvider(userId));

    ref.listen(getUserByIdProvider(userId), (_, user) {
      if (user.hasError && user.error is ErrorResponse && (user.error as ErrorResponse).type == userNotFoundException) {
        context.pushNamed(AppRoute.createProfile.name);
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
