import 'package:bark_authentication/src/token/refresh/body.dart';
import 'package:bark_authentication/src/token/refresh/header.dart';

class BarkRefreshToken {
  final String rawToken;
  final BarkRefreshTokenHeader header;
  final BarkRefreshTokenBody body;

  BarkRefreshToken({
    required this.rawToken,
    required this.header,
    required this.body,
  });
}
