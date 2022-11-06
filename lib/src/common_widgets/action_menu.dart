import 'package:flutter/material.dart';

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
        return "Bearbeiten";
      case DialogAction.delete:
        return "Löschen";
      case DialogAction.cancel:
        return "Abbrechen";
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
          // title: Text(AppLocalizations.of(context)!.actionDialogTitle),
          actionsPadding: EdgeInsets.zero,
          actions: [
            ...getActions(actions),
          ],
        );
      });
}
