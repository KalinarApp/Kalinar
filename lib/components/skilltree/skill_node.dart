import 'package:flutter/material.dart';
import 'package:hero/extensions/color_extension.dart';

import '../../models/skilltree/skill_tree.dart';

class SkillNode extends StatelessWidget {
  final Skill skill;
  final List<Skill> parents;

  const SkillNode(this.skill, this.parents, {super.key});

  bool get isUnlockable => !parents.any((element) => !element.isUnlocked);

  Color _generateColorState() {
    var color = skill.color;
    if (!skill.isUnlocked) {
      color = skill.color.darken(.3);

      if (parents.any((element) => !element.isUnlocked)) {
        color = skill.color.darken(.6);
      }
    }

    return color;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isUnlockable ? () => print("clicked") : null,
      child: Container(
          padding: const EdgeInsets.fromLTRB(12, 12, 3, 12),
          alignment: Alignment.bottomRight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _generateColorState(),
          ),
          child: Row(
            children: [
              Text(skill.label),
              const SizedBox(width: 3),
              skill.isUnlocked ? Container(width: 16) : const Icon(Icons.lock, size: 16),
            ],
          )),
    );
  }
}
