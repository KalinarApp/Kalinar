import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_controller.dart';

class SignInScreen extends ConsumerWidget {
  static const String route = "/login";

  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(.9),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(height: 128, "assets/icon.png"),
              ),
              Text("Hero App", style: Theme.of(context).textTheme.headline3),
              const SizedBox(height: 10),
              Text(
                "Erstelle und Skille deinen Pen & Paper Charakter",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 20),
              Text(
                "Du bist bisher noch nicht angemeldet.\nMelde dich jetzt an und beginne damit deinen eigenen Character zu kreieren.",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * .95,
                child: ElevatedButton(
                  onPressed: state.isLoading ? null : ref.read(authControllerProvider.notifier).signIn,
                  child: state.isLoading ? const Center(child: CircularProgressIndicator()) : const Text("sign in"),
                ),
              ),
            ],
          ),
        ));
  }
}
