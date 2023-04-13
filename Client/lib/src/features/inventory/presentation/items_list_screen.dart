import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemsListScreen extends ConsumerStatefulWidget {
  static const String name = "ItemsList";
  static const route = "items";

  const ItemsListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ItemsListScreenState();
}

class _ItemsListScreenState extends ConsumerState<ItemsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(),
      ),
    );
  }
}
