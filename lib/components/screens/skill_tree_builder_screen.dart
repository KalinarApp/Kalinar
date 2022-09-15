import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:hero/components/builder/dragtarget_node.dart';

class SkillTreeBuilderScreen extends StatefulWidget {
  final int size;

  const SkillTreeBuilderScreen(this.size, {super.key});

  @override
  State<SkillTreeBuilderScreen> createState() => _SkillTreeBuilderScreenState();
}

class _SkillTreeBuilderScreenState extends State<SkillTreeBuilderScreen> {
  List<Widget> _buildNodes() {
    List<Widget> widgets = [];
    int minMax = (widget.size / 2).floor();
    for (int x = -minMax; x <= minMax; x++) {
      for (int y = -minMax; y <= minMax; y++) {
        var node = const DragTargetNode().withGridPlacement(columnStart: x + minMax, rowStart: y + minMax);
        widgets.add(node);
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: InteractiveViewer(
        constrained: false,
        boundaryMargin: const EdgeInsets.all(10),
        minScale: 0.01,
        maxScale: 5.6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutGrid(
            rowGap: 50,
            columnGap: 50,
            rowSizes: List.filled(widget.size, auto),
            columnSizes: List.filled(widget.size, auto),
            children: _buildNodes(),
          ),
        ),
      ),
    );
  }
}
