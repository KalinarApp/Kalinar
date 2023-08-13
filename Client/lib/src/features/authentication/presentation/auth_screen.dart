import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthScreen extends ConsumerWidget {
  static const String name = "Login";
  static const String route = "/login";

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref.listen(firebaseAuthProvider, (previous, next) async {
    //   if (next.hasValue) {
    //     final token = await next.value!.getIdTokenResult();
    //     String? groupId;

    //     if (!(token.claims?.containsKey("groups") ?? false)) {
    //       ref.read(userControllerProvider).getCurrentUser();
    //       final user = ref.read(userNotifierProvider).user;
    //       groupId = user?.ownedGroup?.id ?? user?.group?.id;
    //     } else {
    //       groupId = token.claims!["groups"].first.toString();
    //     }

    //     if (null != groupId) {
    //       final prefs = await SharedPreferences.getInstance();
    //       prefs.setString(Constants.currentGroupKey, groupId);
    //     }
    //   }
    // });

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
