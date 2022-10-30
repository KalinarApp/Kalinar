import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/common_widgets/modal.dart';
import 'package:hero/src/common_widgets/save_button.dart';
import 'package:hero/src/features/admin/application/skilltree_controller.dart';
import 'package:hero/src/features/admin/presentation/skilltree/components/modals/node_modal.dart';
import 'package:hero/src/features/admin/presentation/skilltree/components/skilltree_stack.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../domain/node.dart';
import 'components/modals/skilltree_modal.dart';

class SkilltreeBuilderScreen extends ConsumerStatefulWidget {
  static const String name = "SkilltreeBuilder";
  static const String route = "tree";

  const SkilltreeBuilderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SkilltreeBuilderScreenState();
}

class _SkilltreeBuilderScreenState extends ConsumerState<SkilltreeBuilderScreen> {
  final globalKey = GlobalKey();
  late final SkilltreeController controller;
  late final Timer timer;
  final btnController = RoundedLoadingButtonController();

  bool isLoading = false;

  void updatePosition(DragTargetDetails<Node> details) {
    final renderBox = globalKey.currentContext?.findRenderObject() as RenderBox;
    final localOffset = renderBox.globalToLocal(details.offset);
    final topLeftOffset = Offset(localOffset.dx - 16, localOffset.dy - 16);
    ref.read(skilltreeControllerProvider.notifier).addNodeWithPosition(details.data, topLeftOffset);
  }

  @override
  void initState() {
    controller = ref.read(skilltreeControllerProvider.notifier);
    Future.delayed(Duration.zero, () {
      controller.loadLocal();
      controller.startSavingLocal();
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.endSavingLocal();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(skilltreeControllerProvider);

    return Scaffold(
      appBar: AppBar(actions: [
        if (isLoading) const Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator())),
        IconButton(onPressed: controller.deleteLocal, icon: const Icon(Icons.delete)),
        IconButton(onPressed: () => showModal(context, SkilltreeModal()), icon: const Icon(Icons.save))
      ]),
      floatingActionButton: FloatingActionButton(onPressed: () => showModal(context, NodeModal()), child: const Icon(Icons.add)),
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
            child: DragTarget<Node>(
              key: globalKey,
              onAcceptWithDetails: updatePosition,
              onWillAccept: (data) => true,
              builder: (context, _, __) => SkilltreeStack(
                state.nodes,
                controller.getAllEdges(),
                onEditNode: (node) => showModal(context, NodeModal(item: node)),
                onDeleteNode: controller.deleteNode,
                onAddNodeConnection: controller.addPointForEdge,
                onDeleteEdge: controller.removeEdge,
                onSwagEdgeDirection: controller.swapEdges,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
