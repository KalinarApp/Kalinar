import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum DialogAction {
  edit,
  delete,
  loadAsNewSkilltree,
  saveAsBlueprint,
  cancel,
}

extension KnowledgeActionExtension on DialogAction {
  FaIcon getIcon() {
    switch (this) {
      case DialogAction.edit:
        return const FaIcon(Icons.edit);
      case DialogAction.delete:
        return const FaIcon(Icons.delete);
      case DialogAction.cancel:
        return const FaIcon(Icons.cancel);
      case DialogAction.saveAsBlueprint:
        return const FaIcon(FontAwesomeIcons.map);
      case DialogAction.loadAsNewSkilltree:
        return const FaIcon(FontAwesomeIcons.handsHoldingCircle);
    }
  }

  String getTitle(BuildContext context) {
    switch (this) {
      case DialogAction.edit:
        return AppLocalizations.of(context)!.edit;
      case DialogAction.delete:
        return AppLocalizations.of(context)!.delete;
      case DialogAction.cancel:
        return AppLocalizations.of(context)!.cancel;
      case DialogAction.saveAsBlueprint:
        return AppLocalizations.of(context)!.saveAsBlueprint;
      case DialogAction.loadAsNewSkilltree:
        return AppLocalizations.of(context)!.loadAsNewSkilltree;
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
          title: Text(AppLocalizations.of(context)!.actionDialogTitle),
          actionsPadding: EdgeInsets.zero,
          actions: [
            ...getActions(actions),
          ],
        );
      });
}
