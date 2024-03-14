import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nomo_ui_kit/theme/nomo_theme.dart';
import 'package:webon_kit_dart/webon_kit_dart.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.theme.colors;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: colors.primary,
        child: Icon(
          color: colors.onPrimary,
          Icons.add,
        ),
        onPressed: () async {
          final content = await WebonKitDart.scanQR();
          print(content);
        },
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index'),
            onTap: () {},
          );
        },
      ),
    );
  }
}
