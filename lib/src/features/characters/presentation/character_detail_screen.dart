import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common_widgets/loading_indicator.dart';
import '../application/character_controller.dart';
import '../domain/character.dart';

class CharacterDetailScreen extends ConsumerStatefulWidget {
  static const String name = "CharacterDetail";
  static const String route = ":id";

  final String id;

  const CharacterDetailScreen(this.id, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends ConsumerState<CharacterDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ref.read(characterControllerProvider).getById(widget.id),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LoadingIndicator(AppLocalizations.of(context)!.fetchCharacter);
          return Container();
        },
      ),
    );
  }
}
