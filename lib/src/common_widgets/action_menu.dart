import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/Strings.dart';

enum DialogAction {
  edit,
  delete,
  cancel,
}

extension KnowledgeActionExtension on DialogAction {
  Icon getIcon() {
    switch (this) {
      case DialogAction.edit:
        return const Icon(Icons.edit);
      case DialogAction.delete:
        return const Icon(Icons.delete);
      case DialogAction.cancel:
        return const Icon(Icons.cancel);
    }
  }

  String getTitle(BuildContext context) {
    switch (this) {
      case DialogAction.edit:
        return Strings.of(context)!.edit;
      case DialogAction.delete:
        return Strings.of(context)!.delete;
      case DialogAction.cancel:
        return Strings.of(context)!.cancel;
    }
  }
}

Future<DialogAction?> showActionsModal(BuildContext context, {List<DialogAction>? actions}) async {
  List<Widget> getActions(List<DialogAction>? actions) {
    return (actions ?? DialogAction.values)
        .map(
          (element) => DialogAction.cancel == element
              ? TextButton(
                  onPressed: () => Navigator.of(context, rootNavigator: true).pop(
                        DialogAction.cancel,
                      ),
                  child: Text(element.getTitle(context)))
              : ListTile(
                  leading: element.getIcon(),
                  title: Text(element.getTitle(context)),
                  onTap: () => Navigator.of(context, rootNavigator: true).pop(element)),
        )
        .toList();
  }

  return await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(Strings.of(context)!.actionDialogTitle),
          actionsPadding: EdgeInsets.zero,
          actions: [
            ...getActions(actions),
          ],
        );
      });
}
