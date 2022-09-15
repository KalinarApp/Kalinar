import 'package:flutter/material.dart';

class DragTargetNode extends StatelessWidget {
  const DragTargetNode({super.key});

  @override
  Widget build(BuildContext context) {
    return DragTarget(builder: (ctx, candidat, rejected) => Container(width: 5, height: 5, decoration: const BoxDecoration(color: Colors.grey)));
  }
}
