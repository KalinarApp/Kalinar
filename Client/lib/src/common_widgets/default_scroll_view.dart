import 'package:flutter/material.dart';

class DefaultScrollView extends StatelessWidget {
  final List<Widget> children;

  const DefaultScrollView({required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (OverscrollIndicatorNotification overScroll) {
        overScroll.disallowIndicator();
        return false;
      },
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: children),
      )),
    );
  }
}
