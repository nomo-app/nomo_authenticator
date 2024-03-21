import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomo_authenticator/providers/storage_provider.dart';
import 'package:nomo_authenticator/widgets/floating_action_button.dart';
import 'package:nomo_authenticator/widgets/otp_list_tile.dart';
import 'package:nomo_ui_kit/components/app/app_bar/nomo_app_bar.dart';
import 'package:nomo_ui_kit/components/app/scaffold/nomo_scaffold.dart';
import 'package:nomo_ui_kit/components/text/nomo_text.dart';
import 'package:nomo_ui_kit/theme/nomo_theme.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final storageitems = ref.watch(storageProvider);

    return NomoScaffold(
      appBar: NomoAppBar(
        title: NomoText(
          "Nomo Authenticator",
          style: context.theme.typography.h1,
        ),
      ),
      floatingActionButton: const SelectActionButton(),
      child: storageitems.when(
        data: (items) => items.isEmpty
            ? Center(
                child: NomoText(
                  "No Secrets found! \n  Add a new one!",
                  style: context.theme.typography.h1,
                ),
              )
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(8),
                    child: OTPListTile(
                      item: items[index],
                    ),
                  );
                },
              ),
        error: (error, stackTrace) => Center(
          child: Text("Error: $error"),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
