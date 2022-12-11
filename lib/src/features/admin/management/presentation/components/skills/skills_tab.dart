import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../common_widgets/action_menu.dart';
import '../../../../../../common_widgets/async_value_list.dart';
import '../../../../../../utilities/async_value_extension.dart';
import '../../../application/skill_controller.dart';
import '../../../application/skill_list_controller.dart';
import '../../../domain/skill.dart';

import 'edit_skill_screen.dart';
import 'skill_list_item.dart';

class SkillsTab extends ConsumerStatefulWidget {
  const SkillsTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SkillTabState();
}

class _SkillTabState extends ConsumerState<SkillsTab> {
  late final SkillListController listController;
  late final SkillController skillController;

  Future<void> _refreshSkill() async {
    await listController.getAllSkills();
  }

  Future<void> _showActionDialog(Skill item) async {
    final action = await showActionsModal(context, actions: [DialogAction.edit, DialogAction.delete, DialogAction.cancel]);
    if (null == action || !mounted) return;

    switch (action) {
      case DialogAction.edit:
        _editSkill(item);
        break;
      case DialogAction.delete:
        await _deleteSkill(item);
        break;
      default:
        break;
    }
  }

  Future<void> _deleteSkill(Skill skill) async {
    final value = await skillController.deleteSkill(skill.id);
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  void _editSkill(Skill skill) {
    GoRouter.of(context).goNamed(EditSkillScreen.name, queryParams: {"id": skill.id});
  }

  List<Skill> _filter(List<Skill> items, String? query) {
    return items = null == query || query.isEmpty
        ? items
        : items
            .where((skill) =>
                skill.name.toLowerCase().contains(query.toLowerCase()) || (skill.description?.toLowerCase().contains(query.toLowerCase()) ?? false))
            .toList();
  }

  @override
  void initState() {
    listController = ref.read(skillListControllerProvider.notifier);
    skillController = ref.read(skillControllerProvider);
    Future.delayed(const Duration(microseconds: 100), _refreshSkill);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(skillListControllerProvider, (_, state) => state.showSnackbarOnError(context));
    final state = ref.watch(skillListControllerProvider);

    return AsyncValueList(
      state,
      isSearchable: true,
      queryFn: _filter,
      builder: (item) => SkillListItem(item, onLongPress: _showActionDialog, onPress: _editSkill),
      refreshList: _refreshSkill,
    );
  }
}
