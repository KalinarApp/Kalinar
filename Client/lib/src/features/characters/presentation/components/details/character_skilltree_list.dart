import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../admin/skilltrees/domain/skilltree_overview.dart';
import '../../../../admin/skilltrees/presentation/components/overview/skilltrees/skilltree_item.dart';
import '../../../domain/character.dart';
import '../../skilltree_screen.dart';

class CharacterSkilltreeList extends ConsumerWidget {
  final Character character;
  final bool fillContent;

  const CharacterSkilltreeList(this.character, {this.fillContent = false, super.key});
  _openSkilltree(SkilltreeOverview item, BuildContext context) {
    GoRouter.of(context).pushNamed(SkilltreeScreen.name, pathParameters: {"id": item.id});
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = [...character.skilltrees]..sortBy((element) => element.name);
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overScroll) {
        overScroll.disallowIndicator();
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: items.length,
          shrinkWrap: fillContent,
          itemBuilder: (context, index) => SkilltreeItem(items[index], onPress: (item) => _openSkilltree(item, context)),
        ),
      ),
    );
  }
}
