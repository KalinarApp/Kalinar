import 'package:flutter/material.dart';

class ZoomableImage extends StatelessWidget {
  final String imageUrl;

  const ZoomableImage(this.imageUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: double.infinity, width: double.infinity, child: InteractiveViewer(child: Image.network(imageUrl, fit: BoxFit.fill)));
  }
}
