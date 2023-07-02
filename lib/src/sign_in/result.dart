import 'package:bark_authentication/src/token/authentication/authentication_token.dart';
import 'package:bark_authentication/src/token/refresh/refresh_token.dart';

class BarkSignInResult {
  final BarkRefreshToken refreshToken;
  final BarkAuthenticationToken authenticationToken;

  BarkSignInResult({
    required this.refreshToken,
    required this.authenticationToken,
  });
}
