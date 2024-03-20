import 'package:webon_kit_dart/webon_kit_dart.dart';

bool isValidBase32(String secret) {
  // Regular expression for checking valid Base32 characters (A-Z and 2-7)
  final RegExp base32Regex = RegExp(r'^[A-Z2-7]+$');

  // Check if the secret matches the Base32 character set
  return base32Regex.hasMatch(secret);
}

Future<void> setStorage(String value) async {
  final key = "nomo_authenticator";

  final storage = await WebonKitDart.getLocalStorage(key: key);

  await WebonKitDart.setLocalStorage(key: key, value: value);
}
