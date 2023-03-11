import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../utilities/async_value_extension.dart';
import '../../../group_management/application/group_notifier.dart';
import '../../application/controller/traits_controller.dart';
import '../../domain/suggestable.dart';
import '../../domain/suggestion_state.dart';

class EditView<T extends Suggestable> extends ConsumerStatefulWidget {
  final TraitsController controller;
  final AsyncValue<T>? item;
  final List<Widget> children;
  final Widget? errorWidget;
  final GlobalKey<FormBuilderState> formKey;

  const EditView(this.item, {required this.formKey, required this.controller, required this.children, this.errorWidget, super.key});

  @override
  ConsumerState<EditView> createState() => _EditViewState();
}

class _EditViewState extends ConsumerState<EditView> {
  final _rejectionController = TextEditingController();

  Future<void> _save() async {
    if (widget.formKey.currentState?.validate() ?? false) {
      widget.formKey.currentState?.save();
      final data = widget.formKey.currentState?.value;
      if (null != data) {
        final value = null == widget.item ? await widget.controller.create(data) : await widget.controller.update(widget.item!.value!.id, data);
        if (!mounted) return;
        value.showSnackbarOnError(context);
        if (!value.hasError) {
          GoRouter.of(context).pop();
        }
      }
    }
  }

  bool _isCreatorOrAdminOrNew(Suggestable? item) {
    return widget.item == null ||
        _isAdmin() ||
        (null != item && item.creator?.id == FirebaseAuth.instance.currentUser?.uid && item.state == SuggestionState.pending);
  }

  bool _isAdmin() {
    return FirebaseAuth.instance.currentUser?.uid == ref.read(groupNotifierProvider).group?.ownerId;
  }

  String _getSaveButtonTitle(Suggestable? item) {
    final isAdmin = _isAdmin();
    return isAdmin && item?.state == SuggestionState.pending ? AppLocalizations.of(context)!.saveApprove : AppLocalizations.of(context)!.save;
  }

  Future _reject(Suggestable item) async {
    final bool? success = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.reject),
        content: TextField(controller: _rejectionController, decoration: InputDecoration(hintText: AppLocalizations.of(context)!.rejectReason)),
        actions: <Widget>[
          TextButton(child: Text(AppLocalizations.of(context)!.cancel), onPressed: () => Navigator.pop(context)),
          TextButton(child: Text(AppLocalizations.of(context)!.ok), onPressed: () => setState(() => Navigator.pop(context, true))),
        ],
      ),
    );
    if (success ?? false) {
      final value = await widget.controller.reject(item.id, _rejectionController.text);
      if (!mounted) return;
      value.showSnackbarOnError(context);
      if (!value.hasError) {
        GoRouter.of(context).pop();
      }
    }

    _rejectionController.clear();
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ...widget.children,
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: _isCreatorOrAdminOrNew(widget.item?.valueOrNull) ? _save : null,
            child: SizedBox(
              width: double.infinity,
              child: Center(child: Text(_getSaveButtonTitle(widget.item?.valueOrNull), style: Theme.of(context).textTheme.titleLarge)),
            ),
          ),
          if (_isAdmin() && widget.item?.valueOrNull?.state == SuggestionState.pending)
            ElevatedButton(
              onPressed: () => _reject(widget.item!.value!),
              style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
              child: SizedBox(
                  width: double.infinity,
                  child: Center(child: Text(AppLocalizations.of(context)!.reject, style: Theme.of(context).textTheme.titleLarge))),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FormBuilder(
        key: widget.formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: null != widget.item
              ? widget.item!.maybeWhen(error: (error, stackTrace) => widget.errorWidget ?? Container(), orElse: _buildContent)
              : _buildContent(),
        ),
      ),
    );
  }
}
