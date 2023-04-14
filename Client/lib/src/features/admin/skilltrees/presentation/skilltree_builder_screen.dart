import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../common_widgets/modal.dart';
import '../application/skilltree_controller.dart';
import '../domain/node.dart';
import 'components/builder/skilltree_stack.dart';
import 'components/menu/save_menu.dart';
import 'components/modals/node_modal.dart';

class SkilltreeBuilderScreen extends ConsumerStatefulWidget {
  static const String name = "SkilltreeBuilder";
  static const String route = "builder";
  final String? skilltreeId;
  final String? blueprintId;
  final bool blueprintAsNew;

  const SkilltreeBuilderScreen({this.skilltreeId, this.blueprintId, this.blueprintAsNew = false, super.key});

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
    if (null == widget.skilltreeId && null == widget.blueprintId) {
      Future.delayed(Duration.zero, () {
        controller.loadLocal();
        controller.startSavingLocal();
      });
    } else if (null != widget.skilltreeId) {
      Future.delayed(Duration.zero, () => controller.getSkilltreeById(widget.skilltreeId!));
    } else {
      Future.delayed(Duration.zero, () {
        if (widget.blueprintAsNew) {
          controller.loadBlueprintAsNew(widget.blueprintId!);
        } else {
          controller.getBlueprintById(widget.blueprintId!);
        }
      });
    }

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
        const SaveMenu(),
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
                state.skilltree.nodes,
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
