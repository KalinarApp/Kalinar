import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../utilities/async_value_extension.dart';
import '../../../../../../characters/domain/character_overview.dart';
import '../../../../application/skilltree_controller.dart';
import '../../../../domain/skilltree_overview.dart';
import 'skilltree_item.dart';

class SkilltreeCharacterItem extends ConsumerStatefulWidget {
  final List<SkilltreeOverview> skilltrees;
  final Function(SkilltreeOverview skilltree)? onTap;
  final Function(SkilltreeOverview skilltree)? onLongPress;

  const SkilltreeCharacterItem(this.skilltrees, {this.onTap, this.onLongPress, super.key});

  @override
  ConsumerState<SkilltreeCharacterItem> createState() => _SkilltreeCharacterItemState();
}

class _SkilltreeCharacterItemState extends ConsumerState<SkilltreeCharacterItem> {
  Widget _closedContainer(BuildContext context, Function() action) {
    final character = widget.skilltrees.first.character!;
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: ShaderMask(
            shaderCallback: (rect) {
              return const RadialGradient(
                radius: 0.55,
                center: Alignment.center,
                colors: [Colors.black, Colors.transparent],
              ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
            },
            blendMode: BlendMode.dstIn,
            child: null != character.iconUrl
                ? Image.network(
                    character.iconUrl!,
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fitWidth,
                  )
                : null,
          ),
        ),
        Positioned(
          bottom: 10,
          right: 0,
          child: Container(
            width: 150,
            color: Colors.black38,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Text(
              character.name,
              style: Theme.of(context).textTheme.titleMedium,
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          ),
        )
      ],
    );
  }

  Widget _openedContainer(BuildContext context, Function() action) {
    CharacterOverview character = widget.skilltrees.first.character!;

    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: widget.skilltrees.length,
          itemBuilder: (context, index) => SkilltreeItem(
            widget.skilltrees[index],
            onPress: widget.onTap,
            onLongPress: widget.onLongPress,
            onChangeActiveState: (item, state) {
              ref.read(skilltreeControllerProvider.notifier).updateActiveState(item.id, state).then((value) => value.showSnackbarOnError(context));
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      clipBehavior: Clip.hardEdge,
      closedElevation: 4,
      closedColor: Theme.of(context).colorScheme.background,
      closedBuilder: _closedContainer,
      openBuilder: _openedContainer,
    );
  }
}
