import 'package:flutter/widgets.dart';
import 'package:kalinar/src/common_widgets/shimmer_widget.dart';

class LoadingText extends StatelessWidget {
  final Text text;
  final bool isLoading;
  final double loadingWidth;

  const LoadingText(this.text, {this.isLoading = false, this.loadingWidth = 200, super.key});

  @override
  Widget build(BuildContext context) {
    return isLoading ? ShimmerWidget.rectangular(height: text.style?.height ?? 16, width: loadingWidth) : text;
  }
}
