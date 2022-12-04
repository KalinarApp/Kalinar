import 'package:flutter/material.dart';

import 'package:animations/animations.dart';

import 'package:kalinar/src/features/admin/skilltrees/domain/skilltree_overview.dart';

import 'skilltree_item.dart';

class SkilltreeCharacterItem extends StatelessWidget {
  final List<SkilltreeOverview> skilltrees;
  final Function(SkilltreeOverview skilltree)? onTap;
  final Function(SkilltreeOverview skilltree)? onLongPress;

  const SkilltreeCharacterItem(this.skilltrees, {this.onTap, this.onLongPress, super.key});

  Widget _closedContainer(BuildContext context, Function() action) {
    final character = skilltrees.first.character!;
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
    final character = skilltrees.first.character!;

    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: skilltrees.length,
          itemBuilder: (context, index) => SkilltreeItem(
            skilltrees[index],
            onPress: onTap,
            onLongPress: onLongPress,
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
      closedColor: Theme.of(context).backgroundColor,
      closedBuilder: _closedContainer,
      openBuilder: _openedContainer,
    );
  }
}
