bool isValidBase32(String secret) {
  // Regular expression for checking valid Base32 characters (A-Z and 2-7)
  final RegExp base32Regex = RegExp(r'^[A-Z2-7]+$');

  // Check if the secret matches the Base32 character set
  return base32Regex.hasMatch(secret);
}
