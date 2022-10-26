import 'dart:math';

import 'package:flutter/material.dart';

import '../../../domain/edge.dart';

class EdgeWidget extends StatelessWidget {
  final Edge item;
  final Function(Edge edge) onTap;
  const EdgeWidget(this.item, {required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onTap: () => onTap(item),
        child: CustomPaint(
          painter: LinesPainter(
            start: Offset(item.start.xpos, item.start.ypos),
            end: Offset(item.end.xpos, item.end.ypos),
          ),
          child: Container(),
        ),
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
    return (path?.contains(position) ?? false);
  }

  @override
  bool shouldRepaint(LinesPainter oldDelegate) {
    return oldDelegate.start != start || oldDelegate.end != end;
  }
}
