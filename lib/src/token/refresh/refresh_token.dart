import 'dart:convert';

import '../../utils/decode.dart';
import 'body.dart';
import 'header.dart';

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

  String getRawToken() {
    return rawToken;
  }

  BarkRefreshTokenHeader getHeader() {
    return header;
  }

  BarkRefreshTokenBody getBody() {
    return body;
  }

  bool verifyIssueDate() {
    final DateTime now = DateTime.now();
    final DateTime issueDate = DateTime.fromMillisecondsSinceEpoch(
      header.iat * 1000,
    );

    return now.isAfter(issueDate);
  }

  bool verifyExpirationDate() {
    final DateTime now = DateTime.now();
    final DateTime expirationDate = DateTime.fromMillisecondsSinceEpoch(
      header.exp * 1000,
    );

    return now.isBefore(expirationDate);
  }

  bool verifyTime() {
    return verifyIssueDate() && verifyExpirationDate();
  }

  String getApplicationDomain() {
    return header.aud;
  }

  String getAuthenticatorDomain() {
    return header.iss;
  }

  String getTokenIdentifier() {
    return header.jti;
  }

  String getAccountIdentifier() {
    return body.identifier;
  }

  String getInquiry() {
    return body.inquiry;
  }

  @override
  String toString() {
    return "BarkRefreshToken(rawToken: $rawToken, header: $header, body: $body, signature: $signature)";
  }
}
