import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import '../../../../utilities/async_value_extension.dart';
import '../../skilltrees/domain/skilltree_overview.dart';
import '../application/characters_controller.dart';

class SkillpointSelector extends ConsumerStatefulWidget {
  final SkilltreeOverview tree;

  const SkillpointSelector(this.tree, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SkillpointSelectorState();
}

class _SkillpointSelectorState extends ConsumerState<SkillpointSelector> {
  _updateSkillpoints(double value) async {
    final points = value.round();
    final response = await ref.read(charactersProvider.notifier).update(widget.tree.id, points);
    if (!mounted) return;
    response.showSnackbarOnError(context);
  }

  @override
  Widget build(BuildContext context) {
    return SpinBox(
      min: widget.tree.points - widget.tree.leftPoints.toDouble(),
      max: double.maxFinite,
      value: widget.tree.points.toDouble(),
      acceleration: .1,
      incrementIcon: const Icon(Icons.add_circle_outline),
      decrementIcon: const Icon(Icons.remove_circle_outline),
      decoration: InputDecoration(labelText: widget.tree.name, labelStyle: Theme.of(context).textTheme.titleLarge),
      onChanged: _updateSkillpoints,
    );
  }
}
