import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../common_widgets/action_menu.dart';
import '../../../utils/async_value_extension.dart';
import '../../admin/skilltrees/domain/node.dart';
import '../../group_management/application/group_notifier.dart';
import '../../traits/application/controller/skills_controller.dart';
import '../../traits/presentation/edit_skill_screen.dart';
import '../application/controllers/character_controller.dart';
import '../application/controllers/skillpoint_controller.dart';
import '../application/controllers/skilltree_controller.dart';
import 'shared/skilltrees/skillpoints_widget.dart';
import 'shared/skilltrees/skilltree_stack.dart';
import 'shared/skilltrees/statistics_widget.dart';

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
  late final Timer _timer;

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

    await ref.read(skillpointControllerProvider.notifier).getSkillpointsForSkilltree(widget.id);
  }

  Future<void> _showActionDialog(Node item) async {
    final isAdmin = ref.read(groupNotifierProvider).group?.ownerId == FirebaseAuth.instance.currentUser?.uid;

    final action = await showActionsModal(context, actions: [
      if (isAdmin) DialogAction.edit,
      item.isResettable() && !isAdmin ? DialogAction.reset : DialogAction.resetDisabled,
      DialogAction.cancel,
    ]);
    if (null == action || !mounted) return;

    switch (action) {
      case DialogAction.reset:
        final value = await ref.read(skilltreeControllerProvider.notifier).resetNode(widget.id, item.id);
        if (!mounted) return;
        value.showSnackbarOnError(context);
        break;
      case DialogAction.edit:
        ref.read(skillsControllerProvider).getById(item.skillId);
        GoRouter.of(context).pushNamed(EditSkillScreen.name, queryParameters: {"id": item.skillId});
        break;
      case DialogAction.delete:
      case DialogAction.loadAsNewSkilltree:
      case DialogAction.saveAsBlueprint:
      case DialogAction.resetDisabled:
      case DialogAction.cancel:
        break;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      _animationController = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);

      await ref.read(skillpointControllerProvider.notifier).getSkillpointsForSkilltree(widget.id);
      _timer = Timer.periodic(
        const Duration(seconds: 30),
        (timer) async => await ref.read(skillpointControllerProvider.notifier).getSkillpointsForSkilltree(widget.id),
      );

      await ref.read(skilltreeControllerProvider.notifier).getById(widget.id);

      final skilltree = ref.read(skilltreeControllerProvider);

      if (skilltree.hasValue) {
        final firstNode = skilltree.value!.nodes.firstWhere((element) => skilltree.value!.nodes.isNodeUnlockable(element.id, element.cost));
        navigateToNode(firstNode);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(skilltreeControllerProvider);
    final user = FirebaseAuth.instance.currentUser;
    final skillpoints = ref.watch(skillpointControllerProvider);

    return WillPopScope(
      onWillPop: () async {
        await ref.read(characterControllerProvider).get(state.value!.character!.id);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: !kIsWeb,
          actions: [
            SkillpointsWidget(skillpoints),
            const SizedBox(width: 10),
            if (state.hasValue) StatisticsWidget(state.value!),
            const SizedBox(width: 12),
          ],
        ),
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
                data: (data) {
                  final isEditable = null != user?.uid && user!.uid == data.character!.userId;
                  return SkilltreeStack(
                    nodes: data.nodes,
                    currentSkillpoints: skillpoints.currentSkillpoints,
                    edges: ref.read(skilltreeControllerProvider.notifier).getAllEdges(),
                    unlockNode: !isEditable ? null : (node) => _unlockNode(data.id, node.id),
                    onOpenContextMenu: _showActionDialog,
                  );
                },
                orElse: () => Container(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
