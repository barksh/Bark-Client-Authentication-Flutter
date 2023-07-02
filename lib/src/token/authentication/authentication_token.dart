import 'dart:convert';

import '../../utils/decode.dart';
import 'body.dart';
import 'header.dart';

class BarkAuthenticationToken {
  final String rawToken;
  final BarkAuthenticationTokenHeader header;
  final BarkAuthenticationTokenBody body;
  final String signature;

  BarkAuthenticationToken({
    required this.rawToken,
    required this.header,
    required this.body,
    required this.signature,
  });

  factory BarkAuthenticationToken.fromRawToken(String token) {
    final List<String> splited = token.split('.');

    if (splited.length != 3) {
      throw "Invalid Token";
    }

    final String rawHeader = decodeBase64(splited[0]);
    final String rawBody = decodeBase64(splited[1]);
    final String signature = splited[2].toString();

    final BarkAuthenticationTokenHeader header =
        BarkAuthenticationTokenHeader.fromMap(jsonDecode(rawHeader));

    final BarkAuthenticationTokenBody body =
        BarkAuthenticationTokenBody.fromMap(jsonDecode(rawBody));

    return BarkAuthenticationToken(
      rawToken: token,
      header: header,
      body: body,
      signature: signature,
    );
  }

  String getRawToken() {
    return rawToken;
  }

  BarkAuthenticationTokenHeader getHeader() {
    return header;
  }

  BarkAuthenticationTokenBody getBody() {
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

  bool isAutomation() {
    return body.automation;
  }

  bool isAdministrator() {
    return body.administrator;
  }

  @override
  String toString() {
    return "BarkAuthenticationToken(rawToken: $rawToken, header: $header, body: $body, signature: $signature)";
  }
}
