// import 'package:flutter/material.dart';
// import 'package:flutter_auth/models/user_info.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../features/authentication/data/auth_repository.dart';
// import '../../features/authentication/domain/user_info_extensions.dart';
// import '../../features/authentication/presentation/auth/sign_out_button.dart';
// import 'navigation_item.dart';
// import '../../features/skilling/presentation/abilities/ability_list.dart';

// import '../../features/skilling/presentation/skills/list_skills/skill_list.dart';

// class AppDrawer extends ConsumerWidget {
//   const AppDrawer({super.key});

//   bool _isUser(UserInfo? user) {
//     return null != user && user.isUser();
//   }

//   bool _isAdmin(UserInfo? user) {
//     return null != user && user.isAdmin();
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final state = ref.watch(authChangedProvider);

//     return Drawer(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           DrawerHeader(
//             decoration: BoxDecoration(color: Theme.of(context).primaryColor),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 const Spacer(),
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 8),
//                   child: Text("Hallo ${state.value?.user?.firstName}", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.left),
//                 ),
//                 if (state.value?.user?.groups.isNotEmpty ?? false)
//                   DropdownButton(
//                     onChanged: (value) {},
//                     hint: Text("Wähle deinen Charakter", style: Theme.of(context).textTheme.button, textAlign: TextAlign.left),
//                     alignment: Alignment.centerRight,
//                     items: const [
//                       DropdownMenuItem(value: "Vind", child: Text("Vind")),
//                       DropdownMenuItem(value: "Gwynbleidd", child: Text("Gwynbleidd")),
//                     ],
//                   ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   const NavigationItem(title: "Home", icon: Icons.home, route: "/", isVisible: true),
//                   NavigationItem(title: "Character", icon: Icons.casino, route: SkillList.routeName, isVisible: _isUser(state.value?.user) && false),
//                   NavigationItem(title: "Abilities", icon: Icons.handyman, route: AbilityList.routeName, isVisible: _isAdmin(state.value?.user)),
//                   NavigationItem(title: "Skills", icon: Icons.skateboarding, route: SkillList.routeName, isVisible: _isAdmin(state.value?.user)),
//                   NavigationItem(title: "Skill tree", icon: Icons.safety_divider, route: "Y", isVisible: _isAdmin(state.value?.user)),
//                 ],
//               ),
//             ),
//           ),
//           const SignOutButton(),
//         ],
//       ),
//     );
//   }
// }
