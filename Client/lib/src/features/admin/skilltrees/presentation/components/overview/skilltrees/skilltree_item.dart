import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../domain/skilltree_overview.dart';

class SkilltreeItem extends StatefulWidget {
  final SkilltreeOverview item;
  final Function(SkilltreeOverview item)? onLongPress;
  final Function(SkilltreeOverview item)? onPress;
  final Function(SkilltreeOverview item, bool state)? onChangeActiveState;

  const SkilltreeItem(this.item, {this.onLongPress, this.onPress, this.onChangeActiveState, super.key});

  @override
  State<SkilltreeItem> createState() => _SkilltreeItemState();
}

class _SkilltreeItemState extends State<SkilltreeItem> {
  late SkilltreeOverview item;

  @override
  void initState() {
    item = widget.item;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        onTap: null != widget.onPress ? () => widget.onPress!(item) : null,
        onLongPress: null != widget.onLongPress ? () => widget.onLongPress!(item) : null,
        title: Text(item.name, maxLines: 2, overflow: TextOverflow.ellipsis),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(children: [
            SizedBox(
              width: 100,
              child: Row(
                children: [
                  const FaIcon(FontAwesomeIcons.lightbulb, size: 18),
                  const SizedBox(width: 8),
                  Text("${item.leftPoints} / ${item.points}"),
                ],
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 100,
              child: Row(
                children: [
                  Transform.rotate(angle: pi / 4, child: FaIcon(FontAwesomeIcons.square, color: Theme.of(context).colorScheme.secondary, size: 18)),
                  const SizedBox(width: 8),
                  Text("${item.unlockedNodeCount} / ${item.nodeCount}")
                ],
              ),
            ),
          ]),
        ),
        trailing: null != item.character
            ? InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: null == widget.onChangeActiveState
                    ? null
                    : () {
                        widget.onChangeActiveState!(item, !item.isActiveTree);
                        setState(() {
                          item = item.copyWith(isActiveTree: !item.isActiveTree);
                        });
                      },
                child: Icon(
                  item.isActiveTree ? Icons.check_circle_outline_outlined : Icons.circle_outlined,
                  size: 32,
                ),
              )
            : null,
      ),
    );
  }
}
