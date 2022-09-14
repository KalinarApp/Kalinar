import 'package:flutter/material.dart';

class SkillTree {
  final List<Skill> skills;

  SkillTree({required this.skills});

  List<Edge> generateEdges(Skill skill) {
    List<Edge> edges = [];

    for (final id in skill.childs) {
      final child = skills.firstWhere((element) => id == element.id);
      edges.add(Edge(from: skill.id, to: id));
      
      if (edges.any((element) => element.from == id)) continue;
      edges.addAll(generateEdges(child));
    }

    return edges;
  }
}

class Edge {
  final int from;
  final int to;

  Edge({required this.from, required this.to});
}

class Skill {
  final int id;
  final String label;
  final String description;
  final int cost;
  final bool isUnlocked;
  final Color color;

  final List<int> parents;
  final List<int> childs;

  Skill(
    this.id, {
    required this.label,
    this.description = "",
    this.cost = 1,
    this.isUnlocked = false,
    this.color = Colors.blue,
    this.parents = const [],
    this.childs = const [],
  });
}
