import 'package:flutter/material.dart';
import 'package:nomo_ui_kit/components/buttons/primary/nomo_primary_button.dart';
import 'package:nomo_ui_kit/components/dialog/nomo_dialog.dart';
import 'package:nomo_ui_kit/components/text/nomo_text.dart';
import 'package:nomo_ui_kit/theme/nomo_theme.dart';

class SaveConfirmDialog extends StatelessWidget {
  const SaveConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return NomoDialog(
      maxWidth: 400,
      title: "Are you sure?",
      titleStyle: context.theme.typography.h2,
      content: NomoText(
        "By saving this secret, you will not be able to recover the old settings!",
        style: context.theme.typography.b3,
        textAlign: TextAlign.center,
      ),
      actions: [
        Expanded(
          child: PrimaryNomoButton(
            backgroundColor: context.colors.error,
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
            text: "Save",
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
