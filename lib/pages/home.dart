import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomo_authenticator/widgets/floating_action_button.dart';
import 'package:nomo_authenticator/widgets/otp_list_tile.dart';
import 'package:nomo_ui_kit/components/app/scaffold/nomo_scaffold.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NomoScaffold(
      floatingActionButton: const SelectActionButton(),
      child: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: const OTPListTile(
              name: "hello",
              secret: "adadssdasda",
            ),
          );
        },
      ),
    );
  }
}
