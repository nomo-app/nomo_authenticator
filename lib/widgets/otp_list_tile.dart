import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomo_authenticator/providers/timer_provider.dart';
import 'package:nomo_ui_kit/components/text/nomo_text.dart';
import 'package:nomo_ui_kit/theme/nomo_theme.dart';
import 'package:otp/otp.dart';

class OTPListTile extends ConsumerWidget {
  final String name;
  final String secret;

  const OTPListTile({required this.name, required this.secret, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = DateTime.now().millisecondsSinceEpoch;

    final code = OTP.generateTOTPCodeString(
      secret,
      time,
      algorithm: Algorithm.SHA1,
      isGoogle: true,
    );

    final timeNotifier = OTP.remainingSeconds();

    ref.watch(remainingSecondsProvider);

    return ListTile(
      title: NomoText(name),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          NomoText(
            code,
            style: context.typography.b3,
          ),
          const SizedBox(width: 8),
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
