import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NodeLock extends StatelessWidget {
  final int cost;

  const NodeLock(this.cost, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Stack(
        children: [
          const Positioned.fill(
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.lock,
                size: 28,
                color: Colors.white,
              ),
            ),
          ),
          Positioned.fill(
            top: 12,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                cost.toString(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
