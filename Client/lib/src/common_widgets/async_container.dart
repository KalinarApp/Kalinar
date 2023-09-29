import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'spinner.dart';

class AsyncContainer<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) data;

  const AsyncContainer({super.key, required this.value, required this.data});

  @override
  Widget build(BuildContext context) {
    return value.maybeWhen(data: data, orElse: () => const Center(child: Spinner()));
  }
}
