import 'package:flutter/material.dart';

class CharacterPortrait extends StatelessWidget {
  final String? imageUrl;

  const CharacterPortrait(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(12)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: null != imageUrl ? Image.network(imageUrl!) : Center(child: Text("Kein Portrait ausgewählt.")),
      ),
    );
  }
}
