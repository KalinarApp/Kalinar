import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../application/notifier/character_overview_state_notifier.dart';
import '../character_detail_screen.dart';
import 'character_list_item.dart';

class CharacterList extends ConsumerStatefulWidget {
  final String selectedId;
  final Function(String id) onSelectionChanged;

  const CharacterList({required this.onSelectionChanged, required this.selectedId, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterListState();
}

class _CharacterListState extends ConsumerState<CharacterList> {
  @override
  Widget build(BuildContext context) {
    final characters = ref.watch(ownedCharactersStateProvider);
    final foreignCharacters = ref.watch(foreignCharactersStateProvider);
    final items = [...characters ?? [], ...foreignCharacters ?? []];
    // items.sortBy((e) => e.name);
    final currentIndex = items.indexWhere((element) => widget.selectedId == element.id);

    return Material(
      elevation: 26,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 250),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => CharacterListItem(
                  items[index],
                  isSelected: currentIndex == index,
                  onTap: () => GoRouter.of(context).pushReplacementNamed(CharacterDetailScreen.name, params: {"id": items[index].id}),
                ),
                childCount: items.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
