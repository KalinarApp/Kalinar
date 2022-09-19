import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/skilltree/edge.dart';

class BuildingEdge extends StatefulWidget {
  final Edge edge;

  const BuildingEdge(this.edge, {super.key});

  @override
  State<BuildingEdge> createState() => _BuildingEdgeState();
}

class _BuildingEdgeState extends State<BuildingEdge> {
  bool shouldShowDelete = false;

  _shouldDelete() {
    setState(() {
      shouldShowDelete = !shouldShowDelete;
    });
  }

  @override
  build(_) => Consumer<Edge>(
        builder: (context, value, child) => Stack(children: [
          Icon(Icons.delete),
          CustomPaint(
            size: Size.infinite,
            child: GestureDetector(onTap: _shouldDelete),
            painter: LinesPainter(value.startNode.position, value.endNode.position),
          ),
        ]),
      );
}

class LinesPainter extends CustomPainter {
  final Offset? start, end;

  LinesPainter(this.start, this.end);

  @override
  void paint(Canvas canvas, Size size) {
    if (start == null || end == null) return;
    final startOffset = Offset(start!.dx, start!.dy + 16);
    final endOffset = Offset(end!.dx, end!.dy + 16);
    canvas.drawLine(
        startOffset,
        endOffset,
        Paint()
          ..strokeWidth = 4
          ..color = Colors.redAccent);
  }

  @override
  bool shouldRepaint(LinesPainter oldDelegate) {
    return oldDelegate.start != start || oldDelegate.end != end;
  }
}
