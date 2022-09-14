import 'package:flutter/material.dart';
import 'package:hero/models/skilltree/skill_tree.dart';

class DummyTree {
  static final tree2 = SkillTree(skills: [
    // Core
    Skill(1, label: "Core", color: Colors.amberAccent, isUnlocked: true, parents: [], childs: [2]),

    // More Basics
    Skill(2, label: "Erstes Training", color: Colors.greenAccent, parents: [1], childs: [3, 4, 5]),
    Skill(3, label: "Parade", color: Colors.greenAccent, parents: [2], childs: [4, 7, 8]),
    Skill(4, label: "Eiserner Wille", color: Colors.greenAccent, parents: [2, 3, 5, 7], childs: []),
    Skill(5, label: "Windhund", color: Colors.greenAccent, parents: [2], childs: [6]),
    Skill(6, label: "Dodge", color: Colors.greenAccent, parents: [5], childs: []),
    Skill(7, label: "Kriegsgeist", color: Colors.greenAccent, parents: [3], childs: [18]),
    // Advanced Basics
    Skill(8, label: "Big Chongus", color: Colors.greenAccent, parents: [3], childs: [9, 11]),
    Skill(9, label: "Verteidigungsposition I", color: Colors.greenAccent, parents: [8], childs: [10]),
    Skill(10, label: "More Chongus", color: Colors.greenAccent, parents: [9, 11], childs: []),
    Skill(11, label: "Mächtiges Stampfen I", color: Colors.greenAccent, parents: [8], childs: [12, 14]),
    Skill(12, label: "Mächtiges Stampfen II", color: Colors.greenAccent, parents: [11, 13], childs: []),
    Skill(13, label: "Wieviel Chongus kann ein Mensch haben?", color: Colors.greenAccent, parents: [14], childs: [12]),
    Skill(14, label: "Kampferfahren", color: Colors.greenAccent, parents: [11], childs: [15]),

    // // Advanced Stuff
    Skill(15, label: "Voller Körpereinsatz", color: Colors.redAccent, parents: [14], childs: [16]),
    Skill(16, label: "Glashammer", color: Colors.redAccent, parents: [15, 17], childs: []),
    Skill(17, label: "Doppelschneidiges Schwert", color: Colors.redAccent, parents: [18], childs: [16, 19]),
    Skill(18, label: "Der Weg des Kriegers", color: Colors.redAccent, parents: [7], childs: [17, 19, 20]),
    Skill(19, label: "Kampfraus I", color: Colors.redAccent, parents: [18, 20, 21], childs: [22]),
    Skill(20, label: "Wurfarm", color: Colors.redAccent, parents: [18], childs: [19, 21]),
    Skill(21, label: "Skip Legday", color: Colors.redAccent, parents: [20], childs: [19]),
    Skill(22, label: "Kampfrausch II", color: Colors.redAccent, parents: [19], childs: []),

    // // Magic
    Skill(23, label: "Magie", color: Colors.blueAccent, parents: [1], childs: [24, 25]),
    Skill(24, label: "Brot", color: Colors.blueAccent, parents: [23], childs: [26]),
    Skill(25, label: "Stockbrot", color: Colors.blueAccent, parents: [23], childs: [26]),
    Skill(26, label: "More Stockbrot", color: Colors.blueAccent, parents: [24, 25], childs: []),
  ]);
}
