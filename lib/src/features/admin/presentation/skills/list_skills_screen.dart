import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hero/src/common_widgets/async_value_list.dart';
import 'package:hero/src/features/admin/presentation/skills/edit_skill_screen.dart';
import 'package:hero/src/features/admin/presentation/skills/skill_list_controller.dart';
import 'package:hero/src/features/admin/presentation/skills/components/skill_list_item.dart';
import 'package:hero/src/features/admin/presentation/skills/create_skill_screen.dart';
import 'package:hero/src/utilities/async_value_extension.dart';

import '../../domain/skill.dart';
import 'skill_controller.dart';

class ListSkillsScreen extends ConsumerStatefulWidget {
  static const String name = "ListSkills";
  static const String route = "skills";

  const ListSkillsScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ListSkillsScreenState();
}

class _ListSkillsScreenState extends ConsumerState<ListSkillsScreen> {
  late final SkillListController listController;
  late final SkillController skillController;

  Future<void> _refreshSkill() async {
    await listController.getAllSkills();
  }

  Future<void> _deleteSkill(Skill skill) async {
    await skillController.deleteSkill(skill.id);
  }

  void _editAbility(Skill skill, BuildContext ctx) {
    GoRouter.of(context).goNamed(EditSkillScreen.name, queryParams: {"id": skill.id});
    // Navigator.pushNamed(ctx, EditAbilityScreen.routeName, arguments: ability).then((value) => _refreshAbilities());
  }

  void _createSkill(BuildContext ctx) {
    GoRouter.of(context).goNamed(CreateSkillScreen.name);
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

    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: state.hasError ? null : () => _createSkill(context),
        child: const Icon(Icons.add),
      ),
      body: AsyncValueList(
        state,
        builder: (item) => SkillListItem(item, onDelete: _deleteSkill, onTab: _editAbility),
        refreshList: _refreshSkill,
      ),
    );
  }
}
