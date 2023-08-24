import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:kalinar/src/common_widgets/spinner.dart';

class UsernameEditWidget extends HookWidget {
  final String? initialValue;
  final bool isLoading;
  final Function(String value) onSubmit;

  const UsernameEditWidget({super.key, required this.initialValue, required this.isLoading, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final isEditing = useState(false);
    final controller = useTextEditingController(text: initialValue);

    return isEditing.value
        ? TextField(
            controller: controller,
            autofocus: true,
            onSubmitted: (value) {
              onSubmit(value);
              isEditing.value = false;
            },
            decoration: InputDecoration(
              suffix: IconButton(
                onPressed: () {
                  if (controller.text != initialValue) onSubmit(controller.text);
                  isEditing.value = false;
                },
                icon: const Icon(Icons.check),
              ),
            ))
        : initialValue == null
            ? const Spinner()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const IconButton(onPressed: null, icon: SizedBox(width: 24)),
                  Text(initialValue!, style: Theme.of(context).textTheme.headlineMedium),
                  IconButton(onPressed: () => isEditing.value = true, icon: const Icon(Icons.edit)),
                ],
              );
  }
}
