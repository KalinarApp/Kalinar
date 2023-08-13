import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

RoundedLoadingButtonController useRoundedLoadingButtonController() {
  return use(const _RoundedLoadingButtonControllerHook());
}

class _RoundedLoadingButtonControllerHook extends Hook<RoundedLoadingButtonController> {
  const _RoundedLoadingButtonControllerHook();

  @override
  _RoundedLoadingButtonControllerHookState createState() => _RoundedLoadingButtonControllerHookState();
}

class _RoundedLoadingButtonControllerHookState extends HookState<RoundedLoadingButtonController, _RoundedLoadingButtonControllerHook> {
  late RoundedLoadingButtonController controller;

  @override
  void initHook() {
    super.initHook();
    controller = RoundedLoadingButtonController();
  }

  @override
  RoundedLoadingButtonController build(BuildContext context) {
    return controller;
  }
}
