import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common_widgets/action_menu.dart';
import '../../../../common_widgets/debounced_text_field.dart';
import '../../../../common_widgets/loading_indicator.dart';
import '../../../../utilities/async_value_extension.dart';
import '../../../group_management/application/group_notifier.dart';
import '../../application/abilities_controller.dart';
import '../../application/abilities_state_notifier.dart';
import '../../domain/ability.dart';
import '../../domain/suggestion_state.dart';
import '../edit_ability_screen.dart';
import 'ability_list_item.dart';

class AbilitiesTab extends ConsumerStatefulWidget {
  const AbilitiesTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AbilitiesTabState();
}

class _AbilitiesTabState extends ConsumerState<AbilitiesTab> {
  String? queryString;
  bool isSearchEnabled = true;

  Future _onRefresh() async {
    final value = await ref.read(abilitiesControllerProvider).filter(queryString);
    setState(() => isSearchEnabled = !value.hasError);

    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  void _editAbility(Ability ability) {
    ref.read(abilitiesControllerProvider).getAbilityById(ability.id);
    GoRouter.of(context).goNamed(EditAbilityScreen.name, queryParams: {"id": ability.id});
  }

  Future<void> _deleteAbility(Ability ability) async {
    final value = await ref.read(abilitiesControllerProvider).delete(ability.id);
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  Future _showActionDialog(Ability item) async {
    final actions =
        _isCreatorOrAdminOrNew(item) ? [DialogAction.edit, DialogAction.delete, DialogAction.cancel] : [DialogAction.edit, DialogAction.cancel];
    final action = await showActionsModal(context, actions: actions);
    if (null == action || !mounted) return;

    switch (action) {
      case DialogAction.edit:
        _editAbility(item);
        break;
      case DialogAction.delete:
        await _deleteAbility(item);
        break;
      default:
        break;
    }
  }

  bool _isCreatorOrAdminOrNew(Ability? item) {
    return _isAdmin() || (null != item && item.creator.id == FirebaseAuth.instance.currentUser?.uid && item.state == SuggestionState.pending);
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
    final state = ref.watch(abilitiesStateNotifierProvider);

    return null == state
        ? LoadingIndicator(AppLocalizations.of(context)!.listLoading)
        : RefreshIndicator(
            onRefresh: _onRefresh,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(12.0),
                  sliver: SliverToBoxAdapter(
                      child: Row(
                    children: [
                      Flexible(
                        child: DebouncedTextField(
                          icon: const Icon(Icons.search),
                          title: AppLocalizations.of(context)!.search,
                          isEnabled: isSearchEnabled,
                          canClear: true,
                          onChanged: (currentText) {
                            setState(() => queryString = currentText);
                            _onRefresh();
                          },
                        ),
                      ),
                      // CustomImageButton(icon: const FaIcon(FontAwesomeIcons.filter), onPressed: () {})
                    ],
                  )),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => AbilityListItem(
                            state[index],
                            onPress: _editAbility,
                            onLongPress: _showActionDialog,
                          ),
                      childCount: state.length),
                )
              ],
            ),
          );
  }
}
