import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomo_authenticator/model/storage_item.dart';
import 'package:nomo_authenticator/providers/storage_provider.dart';
import 'package:nomo_authenticator/util/utils.dart';
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
          color: context.theme.colors.background1,
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

            if (qrCode != null) {
              try {
                final uri = Uri.parse(qrCode);

                if (uri.queryParameters['secret'] == null) {
                  throw Exception('Invalid QR Code');
                }
                final storageItem = StorageItem(
                  hostname: uri.queryParameters['issuer']!,
                  code: uri.queryParameters['secret']!,
                );
                ref.read(storageProvider.notifier).addStorageItem(storageItem);
              } catch (e) {
                debugPrint(e.toString());
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: NomoText(
                      'Invalid QR Code',
                      style: typography.h2,
                    ),
                    content: NomoText(
                      'The QR code you scanned is invalid. Please try again.',
                      style: typography.b3,
                    ),
                    actions: [
                      PrimaryNomoButton(
                        padding: const EdgeInsets.all(12),
                        text: "OK",
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              }
            }

            break;
          case "enterCode":
            // ignore: use_build_context_synchronously
            final result = await handleEnterCode(context);
            debugPrint(result?.entries.toString());
            if (result != null) {
              final storageItem = StorageItem(
                hostname: result['hostname']!,
                code: result['code']!,
              );
              ref.read(storageProvider.notifier).addStorageItem(storageItem);
            }
            break;
          default:
            break;
        }
      },
    );
  }

  Future<String?> handleQRScan() async {
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
        maxWidth: 400,
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
              height: 50,
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
              height: 50,
              onPressed: () {
                if (!isValidBase32(codeNotifier.value) &&
                    codeNotifier.value.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => NomoDialog(
                      maxWidth: 400,
                      title: 'Invalid Code',
                      titleStyle: typography.h1,
                      content: NomoText(
                        'The code you entered is invalid. Please try again.',
                        style: typography.b3,
                      ),
                      actions: [
                        Expanded(
                          child: PrimaryNomoButton(
                            height: 50,
                            text: "OK",
                            textStyle: context.theme.typography.b3.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                  return;
                }
                if (hostnameNotifier.value.isEmpty ||
                    codeNotifier.value.isEmpty) {
                  return;
                }

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
