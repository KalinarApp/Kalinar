import 'package:flutter/material.dart';

class CharacterTab extends Tab {
  final Widget tab;

  const CharacterTab({Widget? icon, String? text, required this.tab, EdgeInsetsGeometry margin = const EdgeInsets.only(bottom: 10), super.key})
      : super(icon: icon, text: text, iconMargin: margin);
}
