import 'dart:convert';

String decodeBase64(String input) {
  const Base64Decoder base64Decoder = Base64Decoder();

  final int difference = input.length % 4;
  if (difference != 0) {
    return String.fromCharCodes(
        base64Decoder.convert(input + "=" * (4 - difference)));
  }
  return String.fromCharCodes(base64Decoder.convert(input));
}
