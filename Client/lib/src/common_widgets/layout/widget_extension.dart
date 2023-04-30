import 'package:flutter/material.dart';

import 'size.dart';

extension WidgetExtension on Widget {
  Widget withScaffold({required Widget body, PreferredSize? appBar}) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        if (constraints.maxWidth < mobileMaxWidth) {
          return Scaffold(appBar: appBar, body: body);
        } else {
          return body;
        }
      },
    );
  }
}
