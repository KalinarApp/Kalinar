import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget? child;

  const CustomCard({this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 26,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      clipBehavior: Clip.hardEdge,
      child: child,
    );
  }
}
