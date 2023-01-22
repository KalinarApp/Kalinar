import 'dart:math';

import 'package:flutter/material.dart';

import '../../../domain/edge.dart';

class EdgeWidget extends StatelessWidget {
  final Edge item;
  final Function(Edge edge)? onTap;
  const EdgeWidget(this.item, {this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        onTap: null != onTap ? () => onTap!(item) : null,
        child: CustomPaint(
          painter: LinesPainter(
            start: Offset(item.start.xPos, item.start.yPos),
            end: Offset(item.end.xPos, item.end.yPos),
            color: item.start.isUnlocked && item.end.isUnlocked ? Theme.of(context).colorScheme.secondary : Colors.grey,
          ),
          child: Container(),
        ),
      ),
    ]);
  }
}

class LinesPainter extends CustomPainter {
  final Offset start, end;
  Color color;
  Path? path;

  LinesPainter({required this.start, required this.end, this.color = Colors.grey});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..color = color;

    const arrowSize = 12;
    const arrowAngle = 20 * pi / 180;

    final p1 = Offset(start.dx + 26, start.dy + 26);
    final p2 = Offset(end.dx + 26, end.dy + 26);
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
