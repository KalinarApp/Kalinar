import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router_flow/go_router_flow.dart';

import '../../../../admin/skilltrees/domain/skilltree_overview.dart';
import '../../../../admin/skilltrees/presentation/components/overview/skilltrees/skilltree_item.dart';
import '../../../application/controllers/character_controller.dart';
import '../../../domain/character.dart';
import '../../skilltree_screen.dart';

class CharacterSkilltreeList extends ConsumerStatefulWidget {
  final Character character;

  const CharacterSkilltreeList(this.character, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterSkilltreeListState();
}

class _CharacterSkilltreeListState extends ConsumerState<CharacterSkilltreeList> {
  _openSkilltree(SkilltreeOverview item) {
    GoRouter.of(context)
        .pushNamed(SkilltreeScreen.name, params: {"id": item.id}).then((value) => ref.read(characterControllerProvider).get(widget.character.id));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.character.skilltrees.length,
      itemBuilder: (context, index) => SkilltreeItem(
        widget.character.skilltrees[index],
        onPress: _openSkilltree,
      ),
    );
  }
}
