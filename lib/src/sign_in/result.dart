import 'package:bark/src/token/authentication/authentication_token.dart';
import 'package:bark/src/token/refresh/refresh_token.dart';

class BarkSignInResult {
  final BarkRefreshToken refreshToken;
  final BarkAuthenticationToken authenticationToken;

  BarkSignInResult({
    required this.refreshToken,
    required this.authenticationToken,
  });

  @override
  String toString() {
    return 'BarkSignInResult{refreshToken: $refreshToken, authenticationToken: $authenticationToken}';
  }
}
