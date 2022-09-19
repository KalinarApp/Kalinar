import 'package:flutter/material.dart';
import 'package:hero/components/screens/home_screen.dart';
import 'package:hero/components/screens/skill_tree_builder_screen.dart';
import 'package:hero/components/screens/skill_tree_screen.dart';
import 'package:hero/models/skilltree/nodes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const Hero());
}

class Hero extends StatelessWidget {
  const Hero({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Nodes())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomeScreen(),
        routes: {
          SkillTreeScreen.routeName: (_) => const SkillTreeScreen(),
          SkillTreeBuilderScreen.routeName: (_) => const SkillTreeBuilderScreen(),
        },
      ),
    );
  }
}
