import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kalinar/src/features/group_management/application/group_controller.dart';
import 'package:kalinar/src/features/group_management/application/group_notifier.dart';
import 'package:kalinar/src/utilities/router/routes.dart';

class AuthScreen extends ConsumerWidget {
  static const String name = "Login";
  static const String route = "/login";

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(firebaseAuthProvider, (previous, next) async {
      if (next.hasValue) {
        final token = await next.value!.getIdTokenResult();
        if (token.claims?.containsKey("groups") ?? false) {
          List<Object?> groups = token.claims!["groups"];
          ref.read(groupNotifierProvider).updateGroup(groups.first.toString());
        } else {
          ref.read(groupControllerProvider).check();
        }
      }
    });

    return SignInScreen(
      providers: [
        EmailAuthProvider(),
        UniversalEmailSignInProvider(),
        GoogleProvider(clientId: "718959006853-ena00d420kfimet6gj1dsf72f026jui6.apps.googleusercontent.com"),
      ],
      showAuthActionSwitch: true,
      headerBuilder: (context, constraints, shrinkOffset) => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: AspectRatio(aspectRatio: 1, child: Image.asset("assets/app_icon/icon.png")),
      ),
    );
  }
}
