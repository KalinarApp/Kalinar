import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/user_menu.dart';
import '../../../../utilities/async_value_extension.dart';
import '../application/group_info_controller.dart';

import 'users/user_list.dart';

class ManageGroupScreen extends ConsumerStatefulWidget {
  static const String name = "AdminGroupManagement";
  static const String route = "group-management";

  const ManageGroupScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ManageGroupScreenState();
}

class _ManageGroupScreenState extends ConsumerState<ManageGroupScreen> {
  late GroupInfoController groupInfoController;

  void _copyToClipboard(String code) {
    Clipboard.setData(ClipboardData(text: code)).then((value) =>
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.inviteCopied, textAlign: TextAlign.center))));
  }

  @override
  void initState() {
    groupInfoController = ref.read(groupInfoControllerProvider.notifier);
    Future.delayed(Duration.zero, groupInfoController.getInfo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(groupInfoControllerProvider, (_, state) => state.showSnackbarOnError(context));
    final state = ref.watch(groupInfoControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.inviteTitle),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: UserMenu(),
          )
        ],
      ),
      // drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppLocalizations.of(context)!.inviteDescription, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 10),
            state.maybeWhen(
              data: (value) => TextFormField(
                readOnly: true,
                controller: groupInfoController.controller,
                onTap: () => _copyToClipboard(groupInfoController.controller.text),
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.inviteCopy,
                    suffixIcon: const Icon(Icons.copy_all),
                    suffixIconConstraints: const BoxConstraints.expand(width: 30, height: 48)),
              ),
              orElse: () => TextFormField(
                readOnly: true,
                initialValue: " ",
                decoration: InputDecoration(
                  labelText: AppLocalizations.of(context)!.inviteCopy,
                  prefix: const SizedBox(height: 16, width: 16, child: Center(child: CircularProgressIndicator(strokeWidth: 2))),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const UserList(),
          ],
        ),
      ),
    );
  }
}
