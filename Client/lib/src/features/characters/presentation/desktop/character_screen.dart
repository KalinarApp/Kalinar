import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/loading_indicator.dart';
import '../../../../constants/breakpoints.dart';
import '../../domain/character.dart';
import 'components/big_character_sheet.dart';
import 'components/small_character_sheet.dart';

class CharacterScreen extends ConsumerStatefulWidget {
  final Character? item;

  const CharacterScreen(this.item, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends ConsumerState<CharacterScreen> {
  bool _isOwner(Character character) {
    return FirebaseAuth.instance.currentUser?.uid == character.userId;
  }

  bool _isOwnerOrAdmin(Character character) {
    // return _isOwner(character) || ref.read(userNotifierProvider).user?.ownedGroup?.ownerId == FirebaseAuth.instance.currentUser?.uid;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (null == widget.item) {
      return LoadingIndicator(AppLocalizations.of(context)!.fetchCharacter);
    }

    final item = widget.item!;

    return LayoutBuilder(builder: (ctx, constraints) {
      if (constraints.maxWidth < Breakpoint.tablet) {
        return SmallCharacterSheet(item, isOwner: () => _isOwner(item), isOwnerOrAdmin: () => _isOwnerOrAdmin(item));
      } else {
        return BigCharacterSheet(item, isOwner: () => _isOwner(item), isOwnerOrAdmin: () => _isOwnerOrAdmin(item));
      }
    });
  }
}
