import 'package:flutter/material.dart';
import 'package:hero/models/skilltree/skill_tree.dart';

class DummyTree {
  static final tree = SkillTree(nodes: [
    Skill(1, label: "How to be a Hero", cost: 1),
    Skill(2, label: "Sir Thomas", cost: 1),
    Skill(3, label: "All Guns Blazing", cost: 1, description: "Feure auf 20m Distanz 4 Fernkampfangriffe ab"),
    Skill(4,
        label: "All Guns Smoking",
        cost: 1,
        description: "All Guns Blazing erzeugt zusätzlich eine Rauchwolke mit 10m Durchmesser.\n\nEffektdauer: 2 Runden"),
    Skill(5, label: "All Guns Glowing", cost: 1, description: "Feure auf 10m Distanz 4 Fernampfangriffe ab und mach bei Treffern +3d10 Schaden."),
    Skill(6,
        label: "All Guns Glas Cannon", cost: 1, description: "Feure auf 5m Distanz 4 Fernkampfangriffe ab und mache bei Treffern +10d10 Schaden."),
  ], edges: [
    Edge(from: 1, to: 2),
    Edge(from: 2, to: 3),
    Edge(from: 3, to: 4),
    Edge(from: 3, to: 5),
    Edge(from: 5, to: 6),
  ]);

  static final tree2 = SkillTree(nodes: [
    // Basics
    Skill(1, label: "Magie", color: Colors.blueAccent),
    Skill(2, label: "Core", color: Colors.amberAccent),
    // More Basics
    Skill(3, label: "Erstes Training", color: Colors.greenAccent),
    Skill(4, label: "Parade", color: Colors.greenAccent),
    Skill(5, label: "Eiserner Wille", color: Colors.greenAccent),
    Skill(6, label: "Windhund", color: Colors.greenAccent),
    Skill(7, label: "Dodge", color: Colors.greenAccent),
    Skill(8, label: "Kriegsgeist", color: Colors.greenAccent),
    // Advanced Basics
    Skill(9, label: "Big Chongus", color: Colors.greenAccent),
    Skill(10, label: "Verteidigungsposition I", color: Colors.greenAccent),
    Skill(11, label: "More Chongus", color: Colors.greenAccent),
    Skill(12, label: "Mächtiges Stampfen I", color: Colors.greenAccent),
    Skill(13, label: "Mächtiges Stampfen II", color: Colors.greenAccent),
    Skill(14, label: "Wieviel Chongus kann ein Mensch haben?", color: Colors.greenAccent),
    Skill(15, label: "Kampferfahren", color: Colors.greenAccent),

    // Advanced Stuff
    Skill(16, label: "Voller Körpereinsatz", color: Colors.redAccent),
    Skill(17, label: "Glashammer", color: Colors.redAccent),
    Skill(18, label: "Doppelschneidiges Schwert", color: Colors.redAccent),
    Skill(19, label: "Der Weg des Kriegers", color: Colors.redAccent),
    Skill(20, label: "Kampfraus I", color: Colors.redAccent),
    Skill(21, label: "Wurfarm", color: Colors.redAccent),
    Skill(22, label: "Skip Legday", color: Colors.redAccent),
    Skill(23, label: "Kampfrausch II", color: Colors.redAccent),

    // Magic
    Skill(24, label: "Brot", color: Colors.blueAccent),
    Skill(25, label: "Stockbrot", color: Colors.blueAccent),
    Skill(26, label: "More Stockbrot", color: Colors.blueAccent),
  ], edges: [
    Edge(from: 2, to: 1),
    Edge(from: 2, to: 3),
    Edge(from: 3, to: 6),
    Edge(from: 6, to: 5),
    Edge(from: 4, to: 5),
    Edge(from: 3, to: 5),
    Edge(from: 3, to: 4),
    Edge(from: 4, to: 9),
    Edge(from: 9, to: 10),
    Edge(from: 6, to: 7),
    Edge(from: 4, to: 8),
    Edge(from: 8, to: 5),
    Edge(from: 10, to: 11),
    Edge(from: 9, to: 12),
    Edge(from: 12, to: 11),
    Edge(from: 12, to: 13),
    Edge(from: 12, to: 15),
    Edge(from: 15, to: 16),
    Edge(from: 16, to: 17),
    Edge(from: 8, to: 19),
    Edge(from: 19, to: 18),
    Edge(from: 18, to: 17),
    Edge(from: 19, to: 20),
    Edge(from: 19, to: 21),
    Edge(from: 21, to: 22),
    Edge(from: 21, to: 20),
    Edge(from: 22, to: 20),
    Edge(from: 20, to: 23),
    Edge(from: 1, to: 24),
    Edge(from: 1, to: 25),
    Edge(from: 25, to: 26)
  ]);
}
