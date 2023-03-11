import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({this.width = double.infinity, required this.height, super.key}) : shapeBorder = const RoundedRectangleBorder();

  const ShimmerWidget.circular({this.width = double.infinity, required this.height, this.shapeBorder = const CircleBorder(), super.key});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: const Color.fromRGBO(64, 64, 64, 0.5),
        highlightColor: const Color.fromRGBO(166, 166, 166, 1.0),
        period: const Duration(seconds: 2),
        child: Container(
          width: width,
          height: height,
          decoration: ShapeDecoration(
            color: Colors.grey[400]!,
            shape: shapeBorder,
          ),
        ),
      );
}
