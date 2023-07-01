import 'dart:convert';

import 'package:bark_authentication/src/token/refresh/body.dart';
import 'package:bark_authentication/src/token/refresh/header.dart';

import '../../utils/decode.dart';

class BarkRefreshToken {
  final String rawToken;
  final BarkRefreshTokenHeader header;
  final BarkRefreshTokenBody body;
  final String signature;

  BarkRefreshToken({
    required this.rawToken,
    required this.header,
    required this.body,
    required this.signature,
  });

  factory BarkRefreshToken.fromRawToken(String token) {
    final List<String> splited = token.split('.');

    if (splited.length != 3) {
      throw "Invalid Token";
    }

    final String rawHeader = decodeBase64(splited[0]);
    final String rawBody = decodeBase64(splited[1]);
    final String signature = splited[2].toString();

    final BarkRefreshTokenHeader header =
        BarkRefreshTokenHeader.fromMap(jsonDecode(rawHeader));

    final BarkRefreshTokenBody body =
        BarkRefreshTokenBody.fromMap(jsonDecode(rawBody));

    return BarkRefreshToken(
      rawToken: token,
      header: header,
      body: body,
      signature: signature,
    );
  }

  @override
  String toString() {
    return "BarkRefreshToken(rawToken: $rawToken, header: $header, body: $body, signature: $signature)";
  }
}
