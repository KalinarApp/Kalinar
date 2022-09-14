import 'package:flutter/material.dart';

class SkillTree {
  final List<Skill> nodes;
  final List<Edge> edges;
  

  SkillTree({
    this.nodes = const [],
    this.edges = const [],
  });
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
  final bool isBought;
  final Color color;

  Skill(
    this.id, {
    required this.label,
    this.description = "",
    this.cost = 1,
    this.isBought = false,
    this.color = Colors.blue,
  });
}
