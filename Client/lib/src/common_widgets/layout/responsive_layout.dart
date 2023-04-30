import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({required this.mobile, this.tablet, required this.desktop, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        if (constraints.maxWidth < 500) {
          return mobile;
        } else if (constraints.maxHeight < 1100) {
          return tablet ?? desktop;
        } else {
          return desktop;
        }
      },
    );
  }
}
