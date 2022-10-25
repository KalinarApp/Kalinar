import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/edge.dart';

class EdgetWidget extends ConsumerWidget {
  final Edge item;
  const EdgetWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomPaint(
      size: Size.infinite,
      painter: LinesPainter(Offset(item.start.xpos, item.start.ypos), Offset(item.end.xpos, item.end.ypos)),
    );
  }
}

class LinesPainter extends CustomPainter {
  final Offset? start, end;

  LinesPainter(this.start, this.end);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 2
      ..color = Colors.grey;

    const arrowSize = 15;
    const arrowAngle = 25 * pi / 180;

    if (start == null || end == null) return;

    final p1 = Offset(start!.dx + 16, start!.dy + 16);
    final p2 = Offset(end!.dx + 16, end!.dy + 16);
    final p3 = Offset((p1.dx + p2.dx) / 2, (p1.dy + p2.dy) / 2);

    final dX = p2.dx - p1.dx;
    final dY = p2.dy - p1.dy;
    final angle = atan2(dY, dX);

    final path = Path();
    path.moveTo(p3.dx - arrowSize * cos(angle - arrowAngle), p3.dy - arrowSize * sin(angle - arrowAngle));
    path.lineTo(p3.dx, p3.dy);
    path.lineTo(p3.dx - arrowSize * cos(angle + arrowAngle), p3.dy - arrowSize * sin(angle + arrowAngle));
    path.close();

    canvas.drawPath(path, paint);
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(LinesPainter oldDelegate) {
    return oldDelegate.start != start || oldDelegate.end != end;
  }
}
