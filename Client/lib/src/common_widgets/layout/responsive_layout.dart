import 'package:flutter/material.dart';

import '../../constants/breakpoints.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({required this.mobile, this.tablet, required this.desktop, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        if (constraints.maxWidth < Breakpoint.mobile) {
          return mobile;
        } else if (constraints.maxHeight < Breakpoint.tablet) {
          return tablet ?? desktop;
        } else {
          return desktop;
        }
      },
    );
  }
}
