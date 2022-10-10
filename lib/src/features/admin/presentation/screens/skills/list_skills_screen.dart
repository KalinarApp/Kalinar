import 'package:flutter/material.dart';

class ListSkillsScreen extends StatelessWidget {
  static const name = "ListSkills";
  static const route = "skills";

  const ListSkillsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        // onPressed: () => Navigator.pushNamed(context, MobileEditSkillScreen.routeName),
        child: const Icon(Icons.add),
      ),
      body: ListView(children: const []),
    );
  }
}
