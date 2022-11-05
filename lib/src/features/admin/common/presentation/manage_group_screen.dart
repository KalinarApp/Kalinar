import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    Clipboard.setData(ClipboardData(text: code)).then(
        (value) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Einladungslink kopiert", textAlign: TextAlign.center))));
  }

  @override
  void initState() {
    groupInfoController = ref.read(groupInfoControllerProvider.notifier);
    Future.delayed(const Duration(milliseconds: 100), () => groupInfoController.getInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(groupInfoControllerProvider, (_, state) => state.showSnackbarOnError(context));
    final state = ref.watch(groupInfoControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mitglieder einladen"),
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
            Text(
              "Hier kannst du neue Mitglieder in deine Gruppe einladen. Teile dazu einfach den unten stehenden Einladungslink mit deinen Freunden.",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            state.maybeWhen(
              data: (value) => TextFormField(
                readOnly: true,
                controller: groupInfoController.controller,
                onTap: () => _copyToClipboard(groupInfoController.controller.text),
                decoration: const InputDecoration(
                    labelText: "Einladungscode kopieren",
                    suffixIcon: Icon(Icons.copy_all),
                    suffixIconConstraints: BoxConstraints.expand(width: 30, height: 48)),
              ),
              orElse: () => TextFormField(
                readOnly: true,
                initialValue: " ",
                decoration: const InputDecoration(
                  labelText: "Einladungscode kopieren",
                  prefix: SizedBox(height: 16, width: 16, child: Center(child: CircularProgressIndicator(strokeWidth: 2))),
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
