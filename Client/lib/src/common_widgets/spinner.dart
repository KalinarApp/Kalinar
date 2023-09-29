import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Spinner extends StatelessWidget {
  final double? size;

  const Spinner({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCube(
      size: size ?? 50.0,
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
