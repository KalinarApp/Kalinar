import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common_widgets/navigation/app_drawer.dart';
import '../../authentication/data/auth_repository.dart';
import 'group_info_controller.dart';
import '../../../utilities/async_value_extension.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'create_group_screen.dart';

class NoGroupScreen extends ConsumerWidget {
  const NoGroupScreen({Key? key}) : super(key: key);

  Future<void> _showCreateGroupModal(BuildContext context) async {
    await showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: CreateGroupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(groupInfoControllerProvider, (_, state) => state.showSnackbarOnError(context));
    final authState = ref.watch(authChangedProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Noch kein Mitglied einer Gruppe?")),
      // drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              "Hallo ${authState.value!.user!.firstName}, es sieht so aus, als würdest du bisher noch keiner Gruppe angehören.\nSchlag doch deinem Spielleiter einmal vor, sich die Hero App anzusehen oder frag ihn nach einem Einladungslink.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 40),
            Text(
              "Anleitung zum Beitreten",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            Text(
              "Um einer Gruppe beizutreten öffne den Einladungslink, welchen dir dein Spielleiter zugeschickt hat, du wirst nun gefragt, ob du dieser Gruppe beitreten willst. Wenn du \"Okay\" auswählst, trittst du der Gruppe bei und kannst von da an in der Gruppe agieren.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            Text(
              "Du kannst natürlich auch gerne selbst in die Rolle des Spielleiters schlüpfen und hier eine eigene Gruppe erstellen.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            SizedBox(
                width: MediaQuery.of(context).size.width * .95,
                child: ElevatedButton(onPressed: () async => await _showCreateGroupModal(context), child: const Text("Gruppenleiter werden")))
          ],
        ),
      ),
    );
  }
}
