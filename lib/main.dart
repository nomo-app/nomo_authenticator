import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomo_authenticator/routes.dart';
import 'package:nomo_authenticator/theme.dart';
import 'package:nomo_ui_kit/app/nomo_app.dart';
import 'package:nomo_ui_kit/theme/nomo_theme.dart';

final appRouter = AppRouter();
void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return NomoApp(
      appRouter: appRouter,
      supportedLocales: const [Locale('en', 'US')],
      theme: NomoThemeData(
        colorTheme: ColorMode.LIGHT.theme,
        sizingTheme: SizingMode.LARGE.theme,
        textTheme: typography,
        constants: constants,
      ),
      sizingThemeBuilder: (width) => switch (width) {
        < 480 => sizingSmall,
        < 1080 => sizingMedium,
        _ => sizingLarge,
      },
    );
  }
}
