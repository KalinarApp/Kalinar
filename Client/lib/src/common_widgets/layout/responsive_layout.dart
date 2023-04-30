import 'package:flutter/material.dart';

import 'size.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({required this.mobile, this.tablet, required this.desktop, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        if (constraints.maxWidth < mobileMaxWidth) {
          return mobile;
        } else if (constraints.maxHeight < tabletMaxWidth) {
          return tablet ?? desktop;
        } else {
          return desktop;
        }
      },
    );
  }
}
