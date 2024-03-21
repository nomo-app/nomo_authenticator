import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomo_authenticator/model/storage_item.dart';
import 'package:nomo_authenticator/providers/timer_provider.dart';
import 'package:nomo_authenticator/routes.dart';
import 'package:nomo_router/nomo_router.dart';
import 'package:nomo_ui_kit/components/text/nomo_text.dart';
import 'package:nomo_ui_kit/theme/nomo_theme.dart';
import 'package:otp/otp.dart';

class OTPListTile extends ConsumerWidget {
  final StorageItem item;

  const OTPListTile({required this.item, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = DateTime.now().millisecondsSinceEpoch;

    final code = OTP.generateTOTPCodeString(
      item.code,
      time,
      algorithm: Algorithm.SHA1,
      isGoogle: true,
    );

    final timeNotifier = OTP.remainingSeconds();

    ref.watch(remainingSecondsProvider);

    return ListTile(
      onTap: () =>
          NomoNavigator.of(context).push(EditOTPScreenRoute(item: item)),
      title: NomoText(
        item.hostname,
        style: context.typography.b3,
        fontWeight: FontWeight.bold,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          NomoText(
            code,
            style: context.typography.b3,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(width: 28),
          Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: timeNotifier / 30,
                valueColor: AlwaysStoppedAnimation(context.colors.primary),
              ),
              NomoText(
                timeNotifier.toString(),
                style: context.typography.b3.copyWith(
                  color: context.colors.foreground1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
