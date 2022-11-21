import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:hero/src/features/characters/presentation/components/details/character_information.dart';
import 'package:hero/src/features/characters/presentation/components/details/character_portrait.dart';

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
  final notesController = TextEditingController();
  final inventoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: ref.read(characterControllerProvider).getById(widget.id),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: LoadingIndicator(AppLocalizations.of(context)!.fetchCharacter));
            final character = snapshot.data as Character;
            notesController.text = character.notes ?? "";
            inventoryController.text = character.inventory ?? "";

            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  CharacterInformation(character),
                  TextField(
                    controller: notesController,
                    minLines: 1,
                    maxLines: 10,
                    decoration: InputDecoration(labelText: AppLocalizations.of(context)!.characterNotes),
                  ),
                  TextField(
                    controller: inventoryController,
                    minLines: 1,
                    maxLines: 10,
                    decoration: InputDecoration(labelText: AppLocalizations.of(context)!.characterInventory),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
