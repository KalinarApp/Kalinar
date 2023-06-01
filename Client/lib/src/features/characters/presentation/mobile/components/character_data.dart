import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/character.dart';
import 'character_attributes.dart';
import 'character_information.dart';

class CharacterData extends ConsumerStatefulWidget {
  final Character character;

  const CharacterData(this.character, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterSheetWidgetState();
}

class _CharacterSheetWidgetState extends ConsumerState<CharacterData> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overScroll) {
        overScroll.disallowIndicator();
        return false;
      },
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            CharacterInformation(widget.character),
            Padding(padding: const EdgeInsets.all(4), child: CharacterAttributes(widget.character)),
          ],
        ),
      ),
    );
  }
}
