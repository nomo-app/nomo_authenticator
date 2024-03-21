import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomo_ui_kit/components/buttons/primary/nomo_primary_button.dart';
import 'package:nomo_ui_kit/components/dialog/nomo_dialog.dart';
import 'package:nomo_ui_kit/components/text/nomo_text.dart';
import 'package:nomo_ui_kit/theme/nomo_theme.dart';

class DeleteDialog extends ConsumerWidget {
  const DeleteDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NomoDialog(
      maxWidth: 400,
      title: "Are you sure?",
      titleStyle: context.theme.typography.h2,
      content: Column(
        children: [
          NomoText(
            "By deleting this secret, you will not be able to recover it!",
            style: context.theme.typography.b3,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          NomoText(
            "Make sure you have a backup of the secret before deleting it!",
            style: context.theme.typography.b3,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        Expanded(
          child: PrimaryNomoButton(
            text: "Cancel",
            textStyle: context.theme.typography.b3.copyWith(
              fontWeight: FontWeight.bold,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: PrimaryNomoButton(
            backgroundColor: context.colors.error,
            text: "Delete",
            textStyle: context.theme.typography.b3.copyWith(
              fontWeight: FontWeight.bold,
            ),
            onPressed: () {
              Navigator.of(context).pop(
                true,
              );
            },
          ),
        ),
      ],
    );
  }
}
