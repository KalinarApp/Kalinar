import 'package:collection/collection.dart';
import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../../../../common_widgets/loading_indicator.dart';
import '../../../characters/domain/character_overview.dart';
import '../application/characters_controller.dart';
import 'grouped_characters_list.dart';

class SkillpointsScreen extends ConsumerStatefulWidget {
  static const name = "Skillpoints";
  static const route = "skillpoints";

  const SkillpointsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SkillpointsScreenState();
}

class _SkillpointsScreenState extends ConsumerState<SkillpointsScreen> {
  final scrollController = ScrollController();

  String? query;

  List<CharacterOverview> _filterCharacters(List<CharacterOverview> data) {
    final characters = data.whereNot((element) => element.skilltrees.isEmpty);
    if (query == null) return characters.toList();
    return characters.where((element) => element.name.toLowerCase().contains(query!.toLowerCase())).toList();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, ref.read(charactersProvider.notifier).getAll);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(charactersProvider);
    final appBarColor =
        Theme.of(context).brightness == Brightness.light ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.surface;

    return KeyboardDismisser(
      child: Scaffold(
        appBar: EasySearchBar(
          title: Text(AppLocalizations.of(context)!.distributeSkillpoints),
          backgroundColor: appBarColor,
          searchBackgroundColor: appBarColor,
          onSearch: (value) => setState(() => query = value),
        ),
        body: state.when(
          data: (data) => GroupedCharactersList(characters: _filterCharacters(data), scrollController: scrollController),
          loading: () => const LoadingIndicator(""),
          error: (error, stackTrace) => Center(child: Text(AppLocalizations.of(context)!.errorUnknown)),
        ),
      ),
    );
  }
}
