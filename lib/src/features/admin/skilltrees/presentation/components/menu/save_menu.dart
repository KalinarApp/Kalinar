import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../common_widgets/modal.dart';
import '../../../application/skilltree_controller.dart';
import '../modals/blueprint_modal.dart';
import '../modals/skilltree_modal.dart';

class SaveMenu extends ConsumerStatefulWidget {
  const SaveMenu({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SaveMenuState();
}

class _SaveMenuState extends ConsumerState<SaveMenu> {
  final controller = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(skilltreeControllerProvider);

    return CustomPopupMenu(
      controller: controller,
      menuBuilder: () => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Theme.of(context).dialogBackgroundColor,
          child: IntrinsicWidth(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    controller.hideMenu();
                    ref.read(skilltreeControllerProvider.notifier).resetLocal();
                  },
                  child: ListTile(title: Text(AppLocalizations.of(context)!.deleteChanges)),
                ),
                const Divider(),
                InkWell(
                    onTap: () {
                      controller.hideMenu();
                      if (!state.isBlueprint) {
                        showModal(context, const SkilltreeModal());
                      } else {
                        showModal(context, const BlueprintModal());
                      }
                    },
                    child: ListTile(title: Text(AppLocalizations.of(context)!.save))),
                if (!state.isBlueprint)
                  InkWell(
                    onTap: () {
                      controller.hideMenu();
                      showModal(context, const BlueprintModal());
                    },
                    child: ListTile(
                      title: Text(AppLocalizations.of(context)!.saveAsBlueprint),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      pressType: PressType.singleClick,
      arrowColor: Theme.of(context).dialogBackgroundColor,
      child: const CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Icon(Icons.more_vert),
      ),
    );
  }
}
