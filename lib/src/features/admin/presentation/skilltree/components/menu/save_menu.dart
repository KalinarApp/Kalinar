import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/application/skilltree_controller.dart';

import '../../../../../../common_widgets/modal.dart';
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
                    ref.read(skilltreeControllerProvider.notifier).deleteLocal();
                  },
                  child: const ListTile(title: Text("Änderungen löschen")),
                ),
                const Divider(),
                InkWell(
                    onTap: () {
                      controller.hideMenu();
                      showModal(context, SkilltreeModal());
                    },
                    child: const ListTile(title: Text("Speichern"))),
                InkWell(onTap: null, child: const ListTile(title: Text("Als Vorlage speichern"))),
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
