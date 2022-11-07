import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../application/auth_controller.dart';

class SignInDesktop extends ConsumerStatefulWidget {
  const SignInDesktop({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInDesktopState();
}

class _SignInDesktopState extends ConsumerState<SignInDesktop> {
  final formKey = GlobalKey<FormBuilderState>();
  final saveController = RoundedLoadingButtonController();

  Future<void> _save(WidgetRef ref) async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      final data = formKey.currentState?.value;
      if (null != data) {
        final value = await ref.read(authControllerProvider.notifier).signIn(username: data["username"], password: data["password"]);
        if (!mounted) return;
        if (value.hasError) {
          saveController.error();
          Future.delayed(const Duration(seconds: 3), saveController.reset);
        } else {
          saveController.success();
        }
      } else {
        saveController.error();
        Future.delayed(const Duration(seconds: 3), saveController.reset);
      }
    } else {
      saveController.error();
      Future.delayed(const Duration(seconds: 3), saveController.reset);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    return FormBuilder(
      key: formKey,
      child: Column(
        children: [
          FormBuilderTextField(name: "username", decoration: const InputDecoration(labelText: "Username")),
          FormBuilderTextField(name: "password", obscureText: true, decoration: const InputDecoration(labelText: "Passwort")),
          const SizedBox(height: 10),
          RoundedLoadingButton(
              controller: saveController,
              height: 35,
              onPressed: state.isLoading ? null : () => _save(ref),
              child: state.isLoading ? const Center(child: CircularProgressIndicator()) : const Text("Anmelden"))
        ],
      ),
    );
  }
}
