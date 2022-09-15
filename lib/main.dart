import 'package:flutter/material.dart';
import 'package:hero/components/screens/home_screen.dart';
import 'package:hero/components/screens/skill_tree_builder_screen.dart';
import 'package:hero/components/screens/skill_tree_screen.dart';

void main() {
  runApp(const Hero());
}

class Hero extends StatelessWidget {
  const Hero({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SkillTreeBuilderScreen(101),
      routes: {
        SkillTreeScreen.routeName: (_) => const SkillTreeScreen(),
      },
    );
  }
}
