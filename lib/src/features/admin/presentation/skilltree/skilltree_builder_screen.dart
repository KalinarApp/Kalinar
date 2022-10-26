import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/common_widgets/user_menu.dart';
import 'package:hero/src/features/admin/application/skilltree_controller.dart';
import 'package:hero/src/features/admin/presentation/skilltree/components/draggable_node.dart';
import 'package:hero/src/features/admin/presentation/skilltree/components/edge_widget.dart';
import 'package:hero/src/features/admin/presentation/skilltree/components/node_modal.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../domain/node.dart';

class SkilltreeBuilderScreen extends ConsumerStatefulWidget {
  static const String name = "SkilltreeBuilder";
  static const String route = "tree";

  const SkilltreeBuilderScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SkilltreeBuilderScreenState();
}

class _SkilltreeBuilderScreenState extends ConsumerState<SkilltreeBuilderScreen> {
  final globalKey = GlobalKey();

  Node? firstSelectedNode;

  void _connectNodes(Node selectedNode) {
    if (null == firstSelectedNode) {
      setState(() {
        firstSelectedNode = selectedNode;
      });
    } else if (firstSelectedNode == selectedNode) {
      setState(() {
        firstSelectedNode = null;
      });
    } else if (!firstSelectedNode!.successors.contains(selectedNode.id) && !firstSelectedNode!.precessors.contains(selectedNode.id)) {
      ref.read(skilltreeControllerProvider.notifier).addEdge(firstSelectedNode!, selectedNode);
      firstSelectedNode = null;
    }
  }

  Future<void> _showCreateNodeModal({Node? node}) async {
    await showBarModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: NodeModal(item: node),
      ),
    );
  }

  void updatePosition(Node node, Offset offset) {
    ref.read(skilltreeControllerProvider.notifier).addNodeWithPosition(node, offset);
  }

  int _getNearestSnap(int value, int gridSize) {
    int diff = gridSize - (value % gridSize);
    if (diff > gridSize / 2) return value + diff;
    return value - (value % gridSize);
  }

  _drawGridLines({double space = 32, Color color = Colors.red}) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
        var h = Container(width: 2, height: height, color: color);
        var v = Container(width: width, height: 2, color: color);
        return Stack(children: <Widget>[
          ...List.generate((width / space).round(), (index) => Positioned(left: index * space, child: h)),
          ...List.generate((height / space).round(), (index) => Positioned(top: index * space, child: v)),
        ]);
      },
    );
  }

  Offset _getSnappedPosition(Offset newPosition, int gridSize) {
    Offset snappedValue =
        Offset(_getNearestSnap(newPosition.dx.round(), gridSize).toDouble(), _getNearestSnap(newPosition.dy.round(), gridSize).toDouble());

    return snappedValue;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(skilltreeControllerProvider);
    return Scaffold(
      appBar: AppBar(actions: const [Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu())]),
      floatingActionButton: FloatingActionButton(onPressed: _showCreateNodeModal, child: const Icon(Icons.add)),
      body: InteractiveViewer(
        constrained: false,
        boundaryMargin: const EdgeInsets.all(10.0),
        minScale: 0.01,
        maxScale: 5.6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            width: 2142,
            height: 2142,
            child: DragTarget<Node>(
              key: globalKey,
              onAcceptWithDetails: (details) {
                final renderBox = globalKey.currentContext?.findRenderObject() as RenderBox;
                final localOffset = renderBox.globalToLocal(details.offset);
                final topLeftOffset = Offset(localOffset.dx - 16, localOffset.dy - 16);
                updatePosition(details.data, _getSnappedPosition(topLeftOffset, 16));
              },
              onWillAccept: (data) => true,
              builder: (context, _, __) {
                return Stack(children: [
                  // ToDo: draw edges
                  for (final edge in ref.read(skilltreeControllerProvider.notifier).getAllEdges())
                    EdgeWidget(
                      edge,
                      onDelete: ref.read(skilltreeControllerProvider.notifier).removeEdge,
                      onSwapDirection: ref.read(skilltreeControllerProvider.notifier).swapEdges,
                    ),
                  for (final node in state.nodes)
                    DraggableNode(
                      node,
                      onTap: _connectNodes,
                      onLongPress: _showCreateNodeModal,
                    ),
                  _drawGridLines(color: Theme.of(context).backgroundColor.withOpacity(.1))
                ]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
