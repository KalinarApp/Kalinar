import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../common_widgets/action_menu.dart';
import '../../../../../utilities/async_value_extension.dart';
import '../../../../group_management/application/group_notifier.dart';
import '../../../application/controller/attributes_controller.dart';
import '../../../application/notifier/attributes_state_notifier.dart';
import '../../../domain/attribute.dart';
import '../../../domain/suggestion_state.dart';
import '../../edit_attribute_screen.dart';
import '../list_item.dart';
import '../searchable_list.dart';

class AttributesTab extends ConsumerStatefulWidget {
  const AttributesTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AttributesTabState();
}

class _AttributesTabState extends ConsumerState<AttributesTab> {
  String? queryString;
  bool isSearchEnabled = true;

  Future _onRefresh() async {
    final value = await ref.read(attributesControllerProvider).filter(queryString);
    setState(() => isSearchEnabled = !value.hasError);

    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  void _editAbility(Attribute attribute) {
    ref.read(attributesControllerProvider).getById(attribute.id);
    GoRouter.of(context).goNamed(EditAttributeScreen.name, queryParams: {"id": attribute.id});
  }

  Future<void> _deleteAbility(Attribute attribute) async {
    final value = await ref.read(attributesControllerProvider).delete(attribute.id);
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  Future _showActionDialog(Attribute attribute) async {
    final actions =
        _isCreatorOrAdminOrNew(attribute) ? [DialogAction.edit, DialogAction.delete, DialogAction.cancel] : [DialogAction.edit, DialogAction.cancel];
    final action = await showActionsModal(context, actions: actions);
    if (null == action || !mounted) return;

    switch (action) {
      case DialogAction.edit:
        _editAbility(attribute);
        break;
      case DialogAction.delete:
        await _deleteAbility(attribute);
        break;
      default:
        break;
    }
  }

  bool _isCreatorOrAdminOrNew(Attribute? item) {
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
    final state = ref.watch(attributesStateNotifierProvider);

    return SearchableList(
      state,
      onRefresh: _onRefresh,
      itemBuilder: (context, index) => ListItem(state![index],
          onPress: state[index].isGlobal ? null : _editAbility,
          onLongPress: state[index].isGlobal ? null : _showActionDialog,
          leading: null != state[index].iconData
              ? SizedBox(
                  width: 42,
                  height: 42,
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: Icon(
                        deserializeIcon(jsonDecode(state[index].iconData!)),
                        size: 35,
                      )),
                      if (state[index].isGlobal)
                        Positioned(top: 0, right: 0, child: FaIcon(FontAwesomeIcons.globe, size: 15, color: Theme.of(context).colorScheme.primary))
                    ],
                  ),
                )
              : null),
      onSearchChanged: (query) {
        setState(() => queryString = query);
        _onRefresh();
      },
    );
  }
}
