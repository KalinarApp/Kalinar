import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utilities/async_value_extension.dart';
import '../../admin/skilltrees/domain/node.dart';
import '../application/skillpoint_controller.dart';
import '../application/skilltree_controller.dart';
import 'components/skilltrees/skilltree_stack.dart';

class SkilltreeScreen extends ConsumerStatefulWidget {
  static const String name = "Skilltree";
  static const String route = "skilltrees/:id";

  final String id;

  const SkilltreeScreen(this.id, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SkilltreeScreenState();
}

class _SkilltreeScreenState extends ConsumerState<SkilltreeScreen> with TickerProviderStateMixin {
  final controller = TransformationController();
  late AnimationController _animationController;
  late Animation<Matrix4> _mapAnimation;

  void mapAnimationListener() {
    setState(() {
      final value = Matrix4.inverted(_mapAnimation.value);
      controller.value = value;
    });
  }

  Point<double> calculatePosition(Node node) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height - AppBar().preferredSize.height * 2;

    return Point(node.xPos - width / 2 + 32, node.yPos - height / 2 + 32);
  }

  void navigateToNode(Node dest) {
    Matrix4 start = Matrix4.inverted(controller.value);
    final endPos = calculatePosition(dest);
    final end = Matrix4.identity()..translate(endPos.x, endPos.y);

    _mapAnimation = Matrix4Tween(begin: start, end: end).animate(_animationController);
    _animationController.duration = const Duration(microseconds: 750);
    _mapAnimation.addListener(mapAnimationListener);
    _mapAnimation.addStatusListener(_onMapAnimationStatusChange);
    _animationController.reset();
    _animationController.forward();
  }

  void _onMapAnimationStatusChange(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _mapAnimation.removeListener(mapAnimationListener);
      _mapAnimation.removeStatusListener(_onMapAnimationStatusChange);
    }
  }

  Future<void> _unlockNode(String skilltreeId, String nodeId) async {
    final value = await ref.read(skilltreeControllerProvider.notifier).unlockNode(skilltreeId, nodeId);
    if (!mounted) return;
    value.showSnackbarOnError(context);
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      _animationController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);

      await ref.read(skillpointControllerProvider.notifier).getSkillpointsForSkilltree(widget.id);
      await ref.read(skilltreeControllerProvider.notifier).getById(widget.id);

      final skilltree = ref.read(skilltreeControllerProvider);

      if (skilltree.hasValue) {
        final firstNode = skilltree.value!.nodes.firstWhere((element) => skilltree.value!.nodes.isNodeUnlockable(element.id));
        navigateToNode(firstNode);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(skilltreeControllerProvider);
    final skillpoints = ref.watch(skillpointControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Vebleibende Skillpunkte: ${skillpoints.currentSkillpoints}")),
      body: InteractiveViewer(
        transformationController: controller,
        constrained: false,
        boundaryMargin: const EdgeInsets.all(10.0),
        minScale: 0.01,
        maxScale: 5.6,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: 2000,
            height: 2000,
            child: state.maybeWhen(
              data: (data) => SkilltreeStack(
                nodes: data.nodes,
                edges: ref.read(skilltreeControllerProvider.notifier).getAllEdges(),
                unlockNode: (node) => _unlockNode(data.id, node.id),
              ),
              orElse: () => Container(),
            ),
          ),
        ),
      ),
    );
  }
}
