import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common_widgets/action_menu.dart';
import '../../../../../common_widgets/node_tile.dart';
import '../../../../../utilities/async_value_extension.dart';
import '../../../../group_management/application/group_notifier.dart';
import '../../../application/controller/skills_controller.dart';
import '../../../application/notifier/skills_state_notifier.dart';
import '../../../application/state/filter_state.dart';
import '../../../domain/skill.dart';
import '../../../domain/suggestion_state.dart';
import '../../edit_skill_screen.dart';
import '../list_item.dart';
import '../searchable_list.dart';

class SkillsTab extends ConsumerStatefulWidget {
  const SkillsTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SkillsTabState();
}

class _SkillsTabState extends ConsumerState<SkillsTab> {
  String? queryString;
  bool isSearchEnabled = true;
  FilterState filter = const FilterState();

  Future _onRefresh() async {
    final value = await ref.read(skillsControllerProvider).filter(queryString, allowedStates: filter.states);
    setState(() => isSearchEnabled = !value.hasError);

    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  void _editSkill(Skill skill) {
    ref.read(skillsControllerProvider).getById(skill.id);
    GoRouter.of(context).goNamed(EditSkillScreen.name, queryParameters: {"id": skill.id});
  }

  Future<void> _deleteSkill(Skill skill) async {
    final value = await ref.read(skillsControllerProvider).delete(skill.id);
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  Future _showActionDialog(Skill skill) async {
    final actions =
        _isCreatorOrAdminOrNew(skill) ? [DialogAction.edit, DialogAction.delete, DialogAction.cancel] : [DialogAction.edit, DialogAction.cancel];
    final action = await showActionsModal(context, actions: actions);
    if (null == action || !mounted) return;

    switch (action) {
      case DialogAction.edit:
        _editSkill(skill);
        break;
      case DialogAction.delete:
        await _deleteSkill(skill);
        break;
      default:
        break;
    }
  }

  bool _isCreatorOrAdminOrNew(Skill? item) {
    return _isAdmin() ||
        (null != item?.creator && item!.creator!.id == FirebaseAuth.instance.currentUser?.uid && item.state == SuggestionState.pending);
  }

  bool _isAdmin() {
    return FirebaseAuth.instance.currentUser?.uid == ref.read(groupNotifierProvider).group?.ownerId;
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, _onRefresh);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(skillsStateNotifierProvider);
    return SearchableList(
      state,
      onRefresh: _onRefresh,
      filter: filter,
      onFilterChanged: (state) => setState(() => filter = state),
      itemBuilder: (context, index) => ListItem(
        state![index],
        onPress: _editSkill,
        onLongPress: _showActionDialog,
        leading: SizedBox(
            width: 40,
            height: 40,
            child: null != state[index].iconUrl ? NodeTile(Image(image: CachedNetworkImageProvider(state[index].iconUrl!))) : null),
      ),
      onSearchChanged: (query) {
        setState(() => queryString = query);
        _onRefresh();
      },
    );
  }
}
