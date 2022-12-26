import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  static const String name = "Login";
  static const String route = "/login";

  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providers: [
        EmailAuthProvider(),
        UniversalEmailSignInProvider(),
        GoogleProvider(clientId: "718959006853-ena00d420kfimet6gj1dsf72f026jui6.apps.googleusercontent.com"),
      ],
      showAuthActionSwitch: true,
      subtitleBuilder: (context, action) => Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(action == AuthAction.signIn
            ? 'Welcome to Kalinar! Please sign in to continue.'
            : 'Welcome to Kalinar! Please create an account to continue'),
      ),
      footerBuilder: (context, action) => const Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Text('By signing in, you agree to our terms and conditions.', style: TextStyle(color: Colors.grey)),
      ),
      headerBuilder: (context, constraints, shrinkOffset) => Padding(
        padding: const EdgeInsets.only(top: 20),
        child: AspectRatio(aspectRatio: 1, child: Image.asset("assets/app_icon/icon.png")),
      ),
    );
  }
}
