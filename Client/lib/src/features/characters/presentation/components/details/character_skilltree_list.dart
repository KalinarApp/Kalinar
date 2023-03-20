import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../admin/skilltrees/domain/skilltree_overview.dart';
import '../../../../admin/skilltrees/presentation/components/overview/skilltrees/skilltree_item.dart';
import '../../../domain/character.dart';
import '../../skilltree_screen.dart';

class CharacterSkilltreeList extends ConsumerWidget {
  final Character character;

  const CharacterSkilltreeList(this.character, {super.key});
  _openSkilltree(SkilltreeOverview item, BuildContext context) {
    GoRouter.of(context).pushNamed(SkilltreeScreen.name, params: {"id": item.id});
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: character.skilltrees.length,
      itemBuilder: (context, index) => SkilltreeItem(
        character.skilltrees[index],
        onPress: (item) => _openSkilltree(item, context),
      ),
    );
  }
}
