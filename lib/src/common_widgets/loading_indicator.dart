import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final String text;

  const LoadingIndicator(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 10),
          Text(text),
        ],
      ),
    );
  }
}
