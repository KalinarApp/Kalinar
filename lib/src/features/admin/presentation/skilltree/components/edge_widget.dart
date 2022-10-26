import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/presentation/skilltree/components/edge_menu.dart';

import '../../../domain/edge.dart';

class EdgeWidget extends ConsumerStatefulWidget {
  final Edge item;
  final Function(Edge edge) onDelete;
  final Function(Edge edge) onSwapDirection;
  const EdgeWidget(this.item, {required this.onDelete, required this.onSwapDirection, super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EdgeWidgetState();
}

class _EdgeWidgetState extends ConsumerState<EdgeWidget> {
  bool isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onTap: () => setState(() => isMenuOpen = !isMenuOpen),
        child: CustomPaint(
          painter: LinesPainter(
            start: Offset(widget.item.start.xpos, widget.item.start.ypos),
            end: Offset(widget.item.end.xpos, widget.item.end.ypos),
          ),
          child: Container(),
        ),
      ),
      if (isMenuOpen)
        EdgeMenu(
          widget.item,
          onDelete: () => widget.onDelete(widget.item),
          onSwapDirection: () => widget.onSwapDirection(widget.item),
        ),
    ]);
  }
}

class LinesPainter extends CustomPainter {
  final Offset start, end;
  Path? path;

  LinesPainter({required this.start, required this.end});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..color = Colors.grey;

    const arrowSize = 15;
    const arrowAngle = 25 * pi / 180;

    final p1 = Offset(start.dx + 16, start.dy + 16);
    final p2 = Offset(end.dx + 16, end.dy + 16);
    final p3 = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);

    final dX = p2.dx - p1.dx;
    final dY = p2.dy - p1.dy;
    final angle = atan2(dY, dX);

    path = Path();
    path!.moveTo(p3.dx - arrowSize * cos(angle - arrowAngle), p3.dy - arrowSize * sin(angle - arrowAngle));
    path!.lineTo(p3.dx, p3.dy);
    path!.lineTo(p3.dx - arrowSize * cos(angle + arrowAngle), p3.dy - arrowSize * sin(angle + arrowAngle));
    path!.close();

    canvas.drawPath(path!, paint);
    canvas.drawLine(p1, p2, paint);
  }

  double distance(Offset a, Offset b) {
    return sqrt(pow(a.dx - b.dx, 2) + pow(a.dy - b.dy, 2));
  }

  @override
  bool hitTest(Offset position) {
    // final distanceAC = distance(start, position);
    // final distanceBC = distance(position, end);
    // final distanceAB = distance(start, end);
    // final x = ((distanceAC + distanceBC) - distanceAB).abs();
    // bool isOnLine = x < 0.0001;
    return (path?.contains(position) ?? false);
  }

  @override
  bool shouldRepaint(LinesPainter oldDelegate) {
    return oldDelegate.start != start || oldDelegate.end != end;
  }
}
