import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../common_widgets/user_menu.dart';
import '../../../utils/async_value_extension.dart';
import '../application/invite_controller.dart';

class UserInviteScreen extends ConsumerStatefulWidget {
  static const String name = "Invite";
  static const String route = "/invite";

  final String? inviteCode;

  const UserInviteScreen(this.inviteCode, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserInviteScreenState();
}

class _UserInviteScreenState extends ConsumerState<UserInviteScreen> {
  late final TextEditingController controller;
  final RoundedLoadingButtonController btnController = RoundedLoadingButtonController();

  void _loadGroupInfo() {
    if (controller.text.isNotEmpty) ref.read(inviteControllerProvider.notifier).getInfo(controller.text);
  }

  void _joinGroup(String id, String code) {
    ref.read(inviteControllerProvider.notifier).joinGroup(id, code).then((value) {
      value.showSnackbarOnError(context);
      if (value.hasError) {
        btnController.error();
        Future.delayed(const Duration(seconds: 3), () => btnController.reset());
      } else {
        GoRouter.of(context).goNamed('/home');
      }
    });
  }

  @override
  void initState() {
    controller = TextEditingController(text: widget.inviteCode);
    Future.delayed(Duration.zero, _loadGroupInfo);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(inviteControllerProvider);
    ref.listen(inviteControllerProvider, (previous, next) => next.showSnackbarOnError(context));

    return Scaffold(
      appBar: AppBar(actions: const [
        Padding(padding: EdgeInsets.only(right: 12), child: UserMenu()),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: TextField(controller: controller, enabled: null == widget.inviteCode)),
                IconButton(onPressed: null == widget.inviteCode ? _loadGroupInfo : null, icon: const Icon(Icons.search)),
              ],
            ),
            const SizedBox(height: 20),
            state.when(
              data: (data) => Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.groupJoinTitle(data.owner, data.name),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 10),
                    if (null != data.description) Text("${AppLocalizations.of(context)!.groupAboutTitle}:"),
                    if (null != data.description) SingleChildScrollView(child: Text(data.description!)),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () => GoRouter.of(context).pop(), child: Text(AppLocalizations.of(context)!.cancel)),
                        const SizedBox(width: 12),
                        RoundedLoadingButton(
                          width: 100,
                          height: 30,
                          controller: btnController,
                          onPressed: () => _joinGroup(data.id, controller.text),
                          child: Text(AppLocalizations.of(context)!.join),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              error: (error, stackTrace) => Text(AppLocalizations.of(context)!.groupJoinFailed),
              loading: () => Container(),
            ),
          ],
        ),
      ),
    );
  }
}
