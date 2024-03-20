import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomo_ui_kit/components/buttons/primary/nomo_primary_button.dart';
import 'package:nomo_ui_kit/components/dialog/nomo_dialog.dart';
import 'package:nomo_ui_kit/components/input/textInput/nomo_input.dart';
import 'package:nomo_ui_kit/components/text/nomo_text.dart';
import 'package:nomo_ui_kit/theme/nomo_theme.dart';
import 'package:webon_kit_dart/webon_kit_dart.dart';

class SelectActionButton extends ConsumerWidget {
  const SelectActionButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.theme.colors;
    final typography = context.theme.typography;

    return FloatingActionButton(
      backgroundColor: colors.primary,
      child: Icon(
        color: colors.onPrimary,
        Icons.add,
      ),
      onPressed: () async {
        final result = await showMenu(
          context: context,
          position: RelativeRect.fromSize(
            Rect.fromLTRB(context.width, context.height, 0, 0),
            const Size(0, 0),
          ),
          items: [
            PopupMenuItem(
              value: "scanQR",
              child: NomoText(
                'Scan QR Code',
                style: typography.b3,
              ),
            ),
            PopupMenuItem(
              value: "enterCode",
              child: NomoText(
                'Enter Code Manually',
                style: typography.b3,
              ),
            ),
          ],
        );

        switch (result) {
          case "scanQR":
            final qrCode = await handleQRScan();
            debugPrint(qrCode);
            break;
          case "enterCode":
            // ignore: use_build_context_synchronously
            final result = await handleEnterCode(context);
            debugPrint(result?.entries.toString());

            // WebonKitDart.setLocalStorage(key: key, value: value);

            break;
          default:
            break;
        }
      },
    );
  }

  Future<String> handleQRScan() async {
    final qrCode = await WebonKitDart.scanQR();
    return qrCode;
  }

  Future<Map<String, String>?> handleEnterCode(
    BuildContext context,
  ) async {
    final typography = context.theme.typography;
    final colors = context.theme.colors;
    final codeNotifier = ValueNotifier<String>('');
    final hostnameNotifier = ValueNotifier<String>('');

    final result = await showDialog(
      context: context,
      builder: (context) => NomoDialog(
        title: 'Enter Code Manually',
        titleStyle: typography.h2,
        content: Column(
          children: [
            NomoInput(
              height: 50,
              style: typography.b3,
              valueNotifier: hostnameNotifier,
              placeHolder: 'Enter Hostname',
              placeHolderStyle: typography.b3,
            ),
            const SizedBox(height: 16),
            NomoInput(
              height: 50,
              style: typography.b3,
              placeHolder: 'Enter Code',
              placeHolderStyle: typography.b3,
              valueNotifier: codeNotifier,
            ),
          ],
        ),
        actions: [
          Expanded(
            child: PrimaryNomoButton(
              height: 48,
              backgroundColor: colors.error,
              onPressed: () {
                Navigator.pop(context);
              },
              child: NomoText(
                'Cancel',
                style: typography.b3,
                color: colors.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: PrimaryNomoButton(
              height: 48,
              onPressed: () {
                Navigator.pop(
                  context,
                  {
                    'hostname': hostnameNotifier.value,
                    'code': codeNotifier.value,
                  },
                );
              },
              child: NomoText(
                'Submit',
                style: typography.b3,
                fontWeight: FontWeight.bold,
                color: colors.onPrimary,
              ),
            ),
          ),
        ],
      ),
    );

    return result;
  }
}
