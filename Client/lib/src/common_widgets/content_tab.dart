import 'package:flutter/material.dart';

class ContentTab extends Tab {
  final Widget content;

  const ContentTab({Widget? icon, String? text, required this.content, EdgeInsetsGeometry margin = const EdgeInsets.only(bottom: 10), super.key})
      : super(icon: icon, text: text, iconMargin: margin);
}
