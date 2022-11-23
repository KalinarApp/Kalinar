import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../admin/skilltrees/presentation/components/overview/skilltrees/skilltree_item.dart';
import '../../../domain/character.dart';
import '../../skilltree_screen.dart';

class CharacterSkilltreeList extends ConsumerStatefulWidget {
  final Character character;

  const CharacterSkilltreeList(this.character, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterSkilltreeListState();
}

class _CharacterSkilltreeListState extends ConsumerState<CharacterSkilltreeList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.character.skilltrees.length,
      itemBuilder: (context, index) => SkilltreeItem(
        widget.character.skilltrees[index],
        onPress: (item) => GoRouter.of(context).pushNamed(SkilltreeScreen.name, params: {"id": item.id}),
      ),
    );
  }
}
