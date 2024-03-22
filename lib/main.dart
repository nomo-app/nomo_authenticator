import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nomo_authenticator/routes.dart';
import 'package:nomo_authenticator/theme.dart';
import 'package:nomo_ui_kit/app/nomo_app.dart';
import 'package:nomo_ui_kit/theme/nomo_theme.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:nomo_ui_kit/theme/sub/nomo_color_theme.dart';
import 'package:webon_kit_dart/webon_kit_dart.dart';

final appRouter = AppRouter();

NomoColors? colors;
void main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  final theme = await WebonKitDart.getCurrentAppTheme();
  colors = getColors(theme);

  runApp(const ProviderScope(child: MyApp()));
}

NomoColors getColors(dynamic theme) {
  final colors = theme.nomoColors;

  return NomoColors(
    brightness: colors.brightness,
    primary: colors.primary,
    onPrimary: colors.onPrimary,
    primaryContainer: colors.primaryContainer,
    secondary: colors.secondary,
    onSecondary: colors.onSecondary,
    secondaryContainer: colors.secondaryContainer,
    background1: colors.background1,
    background2: colors.background2,
    background3: colors.background3,
    surface: colors.surface,
    error: colors.error,
    disabled: colors.disabled,
    foreground1: colors.foreground1,
    foreground2: colors.foreground2,
    foreground3: colors.foreground3,
    onDisabled: colors.onDisabled,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return NomoApp(
      appRouter: appRouter,
      supportedLocales: const [Locale('en', 'US')],
      theme: NomoThemeData(
        colorTheme: NomoColorThemeData(
            colors: colors!, key: const ValueKey('appTheme')),
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
