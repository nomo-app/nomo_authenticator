import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomo_authenticator/model/storage_item.dart';
import 'package:nomo_authenticator/providers/storage_provider.dart';
import 'package:nomo_authenticator/widgets/delete_dialog.dart';
import 'package:nomo_authenticator/widgets/save_confirm_dialog.dart';
import 'package:nomo_ui_kit/components/app/app_bar/nomo_app_bar.dart';
import 'package:nomo_ui_kit/components/app/scaffold/nomo_scaffold.dart';
import 'package:nomo_ui_kit/components/buttons/primary/nomo_primary_button.dart';
import 'package:nomo_ui_kit/components/input/textInput/nomo_input.dart';
import 'package:nomo_ui_kit/components/text/nomo_text.dart';
import 'package:nomo_ui_kit/theme/nomo_theme.dart';

class EditOTPScreen extends HookConsumerWidget {
  final StorageItem item;

  EditOTPScreen({super.key, StorageItem? item}) : item = item!;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isObscure = useState(true);

    final hostName = ValueNotifier(item.hostname);
    final secret = ValueNotifier(item.code);

    return NomoScaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: PrimaryNomoButton(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        width: context.width,
        onPressed: () async {
          final StorageItem newItem = StorageItem(
            hostname: hostName.value,
            code: secret.value,
          );

          final result = await showDialog(
              context: context,
              builder: (context) => const SaveConfirmDialog());

          if (result == true) {
            ref.read(storageProvider.notifier).updateStorageItem(item, newItem);
            Navigator.of(context).pop();
          } else {
            hostName.value = item.hostname;
            secret.value = item.code;
          }
        },
        text: "Save",
        textStyle: context.theme.typography.h1.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      appBar: NomoAppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: NomoText(
          "Edit OTP",
          style: context.theme.typography.h1,
        ),
        trailling: IconButton(
          onPressed: () async {
            final result = await showDialog(
                context: context, builder: (context) => const DeleteDialog());

            if (result == true) {
              ref.read(storageProvider.notifier).removeStorageItem(item);
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            }
          },
          icon: Icon(
            Icons.delete,
            color: context.colors.error,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: SizedBox(
          width: context.width,
          child: Card(
            margin: const EdgeInsets.all(16),
            color: context.theme.colors.background1,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NomoText(
                    "Hostname",
                    style: context.theme.typography.b3,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  NomoInput(
                    titleStyle: context.theme.typography.b3.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    placeHolder: item.hostname,
                    valueNotifier: hostName,
                    background: context.theme.colors.background1,
                    placeHolderStyle: context.theme.typography.b3,
                  ),
                  const SizedBox(height: 16),
                  NomoText(
                    "Secret",
                    style: context.theme.typography.b3,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  NomoInput(
                    titleStyle: context.theme.typography.b3.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    initialText: item.code,
                    maxLines: 1,
                    valueNotifier: secret,
                    obscureText: isObscure.value,
                    background: context.theme.colors.background1,
                    style: context.theme.typography.b3,
                    placeHolderStyle: context.theme.typography.b3,
                    padding: const EdgeInsets.only(left: 16),
                    trailling: IconButton(
                      iconSize: 21,
                      icon: isObscure.value == false
                          ? const Icon(Icons.remove_red_eye)
                          : const Icon(Icons.visibility_off),
                      onPressed: () {
                        isObscure.value = !isObscure.value;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.info,
                        color: context.theme.colors.foreground1,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: NomoText(
                          "This is the secret key for your OTP. It is used to generate the code. Please keep it safe!",
                          style: context.theme.typography.b3,
                          color: context.theme.colors.foreground1,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
