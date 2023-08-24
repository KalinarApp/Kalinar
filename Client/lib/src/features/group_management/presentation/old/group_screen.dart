// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// import '../../../common_widgets/user_menu.dart';
// import '../../../utils/async_value_extension.dart';
// import '../../admin/common/application/group_info_controller.dart';
// import 'create_group.dart';
// import 'user_invite_screen.dart';

// class GroupScreen extends ConsumerStatefulWidget {
//   static const String name = "Group";
//   static const String route = "/group";

//   const GroupScreen({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _GroupScreenState();
// }

// class _GroupScreenState extends ConsumerState<GroupScreen> {
//   Future<void> _showCreateGroupModal(BuildContext context) async {
//     await showBarModalBottomSheet(
//       context: context,
//       isDismissible: true,
//       builder: (context) => SingleChildScrollView(
//         controller: ModalScrollController.of(context),
//         child: const CreateGroup(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     ref.listen(groupInfoControllerProvider, (_, state) => state.showNotification(context));

//     return Scaffold(
//       appBar: AppBar(actions: const [
//         Padding(padding: EdgeInsets.only(right: 12.0), child: UserMenu()),
//       ]),
//       body: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 10),
//             Text(AppLocalizations.of(context)!.groupNotInGroupText(FirebaseAuth.instance.currentUser?.displayName ?? ""),
//                 style: Theme.of(context).textTheme.bodyMedium),
//             TextButton(
//               onPressed: () => GoRouter.of(context).pushNamed(UserInviteScreen.name),
//               child: Text(AppLocalizations.of(context)!.groupGotAnInviteCode),
//             ),
//             Text(
//               AppLocalizations.of(context)!.groupInstructionTitle,
//               style: Theme.of(context).textTheme.bodyLarge,
//               textAlign: TextAlign.left,
//             ),
//             const SizedBox(height: 10),
//             Text(AppLocalizations.of(context)!.groupInstruction, style: Theme.of(context).textTheme.bodyMedium),
//             const Spacer(),
//             Text(AppLocalizations.of(context)!.groupInstructionGM, style: Theme.of(context).textTheme.bodyMedium),
//             const SizedBox(height: 10),
//             SizedBox(
//                 width: MediaQuery.of(context).size.width * .95,
//                 child: ElevatedButton(
//                     onPressed: () async => await _showCreateGroupModal(context), child: Text(AppLocalizations.of(context)!.groupBeAGM)))
//           ],
//         ),
//       ),
//     );
//   }
// }
