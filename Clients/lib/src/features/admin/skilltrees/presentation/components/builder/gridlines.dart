import 'package:flutter/material.dart';

class Gridlines extends StatelessWidget {
  final Color color;
  final double space;

  const Gridlines({this.color = Colors.grey, this.space = 32, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
        var h = Container(width: 2, height: height, color: color);
        var v = Container(width: width, height: 2, color: color);
        return Stack(children: <Widget>[
          ...List.generate((width / space).round(), (index) => Positioned(left: index * space, child: h)),
          ...List.generate((height / space).round(), (index) => Positioned(top: index * space, child: v)),
        ]);
      },
    );
  }
}
