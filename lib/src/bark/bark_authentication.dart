import 'package:bark/src/sign_in/result.dart';
import 'package:bark/src/sign_in/sign_in.dart';
import 'package:bark/src/token/authentication/authentication_token.dart';
import 'package:bark/src/token/refresh/refresh_token.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logo/logo.dart';

class BarkAuthentication {
  static const String rawAuthenticationStorageKey = "bark-authentication-token";
  static const String rawRefreshStorageKey = "bark-refresh-token";

  final String authenticatorDomain;
  final String targetDomain;

  final Uri? overrideAuthenticationModuleDomain;
  final Uri? overrideAuthenticationUiDomain;

  late final Logo logger;
  late final FlutterSecureStorage storage;

  late final String authenticationStorageKey;
  late final String refreshStorageKey;

  BarkAuthentication({
    required this.authenticatorDomain,
    required this.targetDomain,
    this.overrideAuthenticationModuleDomain,
    this.overrideAuthenticationUiDomain,
    LogoLogLevel? logLevel,
    String? storageScope,
  }) {
    logger = Logo(logLevel ?? LogoLogLevel.info());
    storage = const FlutterSecureStorage();

    if (storageScope != null) {
      authenticationStorageKey = "$storageScope-$rawAuthenticationStorageKey";
      refreshStorageKey = "$storageScope-$rawRefreshStorageKey";
    } else {
      authenticationStorageKey = rawAuthenticationStorageKey;
      refreshStorageKey = rawRefreshStorageKey;
    }
  }

  Future<BarkAuthenticationToken?> ensureAuthenticationToken() async {
    final BarkAuthenticationToken? token = await getAuthenticationToken();

    if (token != null) {
      return token;
    }

    logger.verbose(
      "Bark - Ensure Authentication Token Not Found in Storage",
    );

    final BarkSignInResult? result = await signIn();

    logger.verbose(
      "Bark - Ensure Authentication Token Sign In Result: $result",
    );

    if (result == null) {
      return null;
    }

    return result.authenticationToken;
  }

  Future<BarkRefreshToken?> ensureRefreshToken() async {
    final BarkRefreshToken? token = await getRefreshToken();

    if (token != null) {
      return token;
    }

    logger.verbose(
      "Bark - Ensure Refresh Token Not Found in Storage",
    );

    final BarkSignInResult? result = await signIn();

    logger.verbose(
      "Bark - Ensure Refresh Token Sign In Result: $result",
    );

    if (result == null) {
      return null;
    }

    return result.refreshToken;
  }

  Future<BarkAuthenticationToken?> getAuthenticationToken() async {
    final String? rawToken = await storage.read(
      key: authenticationStorageKey,
    );

    logger.verbose(
      "Bark - Get Authentication Token: $rawToken",
    );

    if (rawToken == null) {
      return null;
    }

    final BarkAuthenticationToken token =
        BarkAuthenticationToken.fromRawToken(rawToken);

    if (token.verifyTime()) {
      return token;
    }

    final BarkRefreshToken? currentRefreshToken = await getRefreshToken();

    if (currentRefreshToken == null) {
      logger.verbose(
        "Bark - Unable to get current refresh token",
      );

      return null;
    }

    final BarkAuthenticationToken? refreshedToken = await refreshToken(
      currentRefreshToken,
    );

    if (refreshedToken == null) {
      logger.verbose(
        "Bark - Unable to get refreshed token",
      );

      return null;
    }

    return refreshedToken;
  }

  Future<BarkRefreshToken?> getRefreshToken() async {
    final String? rawToken = await storage.read(
      key: refreshStorageKey,
    );

    logger.verbose(
      "Bark - Get Refresh Token: $rawToken",
    );

    if (rawToken == null) {
      return null;
    }

    final BarkRefreshToken token = BarkRefreshToken.fromRawToken(rawToken);

    if (token.verifyTime()) {
      return token;
    }

    return null;
  }

  Future<BarkSignInResult?> signIn() async {
    final BarkAuthenticationSignIn signIn = _buildSignIn();

    final BarkSignInResult? result = await signIn.signIn();

    if (result == null) {
      return null;
    }

    await storage.delete(
      key: authenticationStorageKey,
    );

    await storage.write(
      key: authenticationStorageKey,
      value: result.authenticationToken.rawToken,
    );

    logger.verbose(
      "Bark - Write Authentication Token: ${result.authenticationToken.rawToken}",
    );

    await storage.delete(
      key: refreshStorageKey,
    );

    await storage.write(
      key: refreshStorageKey,
      value: result.refreshToken.rawToken,
    );

    logger.verbose(
      "Bark - Write Refresh Token: ${result.refreshToken.rawToken}",
    );

    return result;
  }

  Future<BarkAuthenticationToken?> refreshToken(
    BarkRefreshToken refreshToken,
  ) async {
    final BarkAuthenticationSignIn signIn = _buildSignIn();

    final BarkAuthenticationToken? token = await signIn.refreshToken(
      refreshToken,
    );

    if (token == null) {
      return null;
    }

    await storage.delete(
      key: authenticationStorageKey,
    );

    await storage.write(
      key: authenticationStorageKey,
      value: token.rawToken,
    );

    logger.verbose(
      "Bark - Write Authentication Token after Refresh: ${token.rawToken}",
    );

    return token;
  }

  Future<void> signOut() async {
    await storage.delete(
      key: authenticationStorageKey,
    );

    await storage.delete(
      key: refreshStorageKey,
    );
  }

  BarkAuthenticationSignIn _buildSignIn() {
    final BarkAuthenticationSignIn signIn = BarkAuthenticationSignIn(
      authenticatorDomain: authenticatorDomain,
      targetDomain: targetDomain,
      overrideAuthenticationModuleDomain: overrideAuthenticationModuleDomain,
      overrideAuthenticationUiDomain: overrideAuthenticationUiDomain,
      logger: logger,
    );

    return signIn;
  }
}
