import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ElevatedLoadingButton extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final double? width;
  final double? height;
  final Function() action;

  const ElevatedLoadingButton({super.key, required this.child, required this.isLoading, required this.action, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) => ElevatedButton(
          onPressed: isLoading ? null : action,
          child: FittedBox(
            child: isLoading ? SpinKitFadingCube(size: constraints.maxHeight * .6, color: Theme.of(context).colorScheme.primary) : child,
          ),
        ),
      ),
    );
  }
}
