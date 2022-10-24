import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/common_widgets/user_menu.dart';
import 'package:hero/src/features/admin/presentation/skilltree/node_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SkilltreeBuilderScreen extends ConsumerStatefulWidget {
  static const String name = "SkilltreeBuilder";
  static const String route = "tree";

  const SkilltreeBuilderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SkilltreeBuilderScreenState();
}

class _SkilltreeBuilderScreenState extends ConsumerState<SkilltreeBuilderScreen> {
  Future<void> _showCreateNodeModal(BuildContext context) async {
    await showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: NodeModal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: const [Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu())]),
      floatingActionButton: FloatingActionButton(onPressed: () => _showCreateNodeModal(context), child: const Icon(Icons.add)),
      body: InteractiveViewer(
        constrained: false,
        boundaryMargin: const EdgeInsets.all(10.0),
        minScale: 0.01,
        maxScale: 5.6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 2000,
            height: 2000,
            child: Stack(children: const []),
          ),
        ),
      ),
    );
  }
}
