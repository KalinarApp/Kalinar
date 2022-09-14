import 'package:flutter/material.dart';
import 'package:hero/components/skilltree/skill_tree_view.dart';

class SkillTreeScreen extends StatefulWidget {
  static const routeName = "skilltree";

  const SkillTreeScreen({super.key});

  @override
  State<SkillTreeScreen> createState() => _SkillTreeScreenState();
}

class _SkillTreeScreenState extends State<SkillTreeScreen> {
  int availablePoints = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Skill Baum"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(backgroundColor: Colors.amber, maxRadius: 15, child: Text(availablePoints.toString())),
            ),
          ],
        ),
        body: SkillTreeView(availablePoints));
  }
}
