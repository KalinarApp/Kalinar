import 'package:flutter/cupertino.dart';

import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future showModal(BuildContext context, Widget child) async {
  await showBarModalBottomSheet(
    context: context,
    isDismissible: true,
    builder: (context) => SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: child,
    ),
  ).then((value) {
    if (value) GoRouter.of(context).pop();
  });
}
