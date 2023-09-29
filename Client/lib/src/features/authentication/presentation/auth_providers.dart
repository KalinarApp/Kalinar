import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
List<AuthProvider<AuthListener, AuthCredential>> authProviders(AuthProvidersRef ref) {
  return [
    EmailAuthProvider(),
    UniversalEmailSignInProvider(),
    GoogleProvider(clientId: "718959006853-ena00d420kfimet6gj1dsf72f026jui6.apps.googleusercontent.com"),
  ];
}
