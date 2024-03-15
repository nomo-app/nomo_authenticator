import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomo_ui_kit/components/text/nomo_text.dart';
import 'package:nomo_ui_kit/theme/nomo_theme.dart';
import 'package:otp/otp.dart';

class OTPListTile extends ConsumerStatefulWidget {
  const OTPListTile({required this.name, required this.secret, super.key});

  final String name;
  final String secret;

  @override
  ConsumerState<OTPListTile> createState() => _OTPListTileState();
}

class _OTPListTileState extends ConsumerState<OTPListTile> {
  var code = "";
  ValueNotifier<int> timeNotifier = ValueNotifier(0);
  int time = 0;

  @override
  void initState() {
    code = OTP.generateTOTPCodeString(
        widget.secret, DateTime.now().millisecondsSinceEpoch,
        interval: 30, algorithm: Algorithm.SHA512);

    time = OTP.remainingSeconds();

    timeNotifier.value = time;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: NomoText(widget.name),
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
                value: timeNotifier.value / 30,
                valueColor: AlwaysStoppedAnimation(context.colors.primary),
              ),
              NomoText(
                timeNotifier.value.toString(),
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
