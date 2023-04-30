import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common_widgets/layout/size.dart';
import '../../../common_widgets/user_menu.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String name = "Home";
  static const String route = "/home";

  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late final bool hasGroup;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constraints) => Scaffold(
        appBar: isMobile(constraints) ? AppBar(actions: const [Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu())]) : null,
        body: Center(child: Image.asset("assets/images/kali/hello.gif", width: MediaQuery.of(context).size.width)),
      ),
    );
  }
}
