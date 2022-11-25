import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../common_widgets/action_menu.dart';
import '../../../../../../common_widgets/async_value_list.dart';
import '../../../../../../utilities/async_value_extension.dart';
import '../../../application/attribute_controller.dart';
import '../../../application/attribute_list_controller.dart';
import '../../../domain/attribute.dart';

import 'attribute_list_item.dart';
import 'edit_attribute_screen.dart';

class AttributesTab extends ConsumerStatefulWidget {
  const AttributesTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AttributeTabState();
}

class _AttributeTabState extends ConsumerState<AttributesTab> {
  late final AttributeListController listController;
  late final AttributeController skillController;

  Future<void> _refreshAttribute() async {
    await listController.getAllAttributes();
  }

  Future<void> _showActionDialog(Attribute item) async {
    final action = await showActionsModal(context, actions: [DialogAction.edit, DialogAction.delete, DialogAction.cancel]);
    if (null == action || !mounted) return;

    switch (action) {
      case DialogAction.edit:
        _editAttribute(item);
        break;
      case DialogAction.delete:
        await _deleteAttribute(item);
        break;
      case DialogAction.cancel:
      case DialogAction.loadAsNewSkilltree:
      case DialogAction.saveAsBlueprint:
        break;
    }
  }

  Future<void> _deleteAttribute(Attribute skill) async {
    final value = await skillController.deleteSkill(skill.id);
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  void _editAttribute(Attribute attribute) {
    GoRouter.of(context).goNamed(EditAttributeScreen.name, queryParams: {"id": attribute.id});
  }

  @override
  void initState() {
    listController = ref.read(attributeListControllerProvider.notifier);
    skillController = ref.read(attributeControllerProvider);
    Future.delayed(const Duration(microseconds: 100), _refreshAttribute);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(attributeListControllerProvider, (_, state) => state.showSnackbarOnError(context));
    final state = ref.watch(attributeListControllerProvider);

    return AsyncValueList(
      state,
      sort: (data) => data.sort((a, b) => b.isGlobal ? 1 : -1),
      builder: (item) => AttributeListItem(item, onLongPress: _showActionDialog),
      refreshList: _refreshAttribute,
    );
  }
}
