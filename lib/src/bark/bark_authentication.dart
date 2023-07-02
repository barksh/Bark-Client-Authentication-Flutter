import 'package:bark/bark.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logo/logo.dart';

class BarkAuthentication {
  static const String authenticationStorageKey = "bark-authentication-token";
  static const String refreshStorageKey = "bark-refresh-token";

  final String authenticatorDomain;
  final String targetDomain;

  final Uri? overrideAuthenticationModuleDomain;
  final Uri? overrideAuthenticationUiDomain;

  late final Logo logger;
  late final FlutterSecureStorage storage;

  BarkAuthentication({
    required this.authenticatorDomain,
    required this.targetDomain,
    this.overrideAuthenticationModuleDomain,
    this.overrideAuthenticationUiDomain,
    LogoLogLevel? logLevel,
  }) {
    logger = Logo(logLevel ?? LogoLogLevel.info());
    storage = const FlutterSecureStorage();
  }

  Future<BarkAuthenticationToken?> ensureToken() async {
    final BarkAuthenticationToken? token = await getAuthenticationToken();

    if (token != null) {
      return token;
    }

    return signIn();
  }

  Future<BarkAuthenticationToken?> getAuthenticationToken() async {
    final String? rawToken = await storage.read(
      key: authenticationStorageKey,
    );

    if (rawToken == null) {
      return null;
    }

    return BarkAuthenticationToken.fromRawToken(rawToken);
  }

  Future<BarkAuthenticationToken?> getRefreshToken() async {
    final String? rawToken = await storage.read(
      key: refreshStorageKey,
    );

    if (rawToken == null) {
      return null;
    }

    return BarkAuthenticationToken.fromRawToken(rawToken);
  }

  Future<BarkAuthenticationToken?> signIn() async {
    final BarkAuthenticationSignIn signIn = BarkAuthenticationSignIn(
      authenticatorDomain: authenticatorDomain,
      targetDomain: targetDomain,
      overrideAuthenticationModuleDomain: overrideAuthenticationModuleDomain,
      overrideAuthenticationUiDomain: overrideAuthenticationUiDomain,
      logger: logger,
    );

    final BarkSignInResult? result = await signIn.signIn();

    if (result == null) {
      return null;
    }

    await storage.write(
      key: authenticationStorageKey,
      value: result.authenticationToken.rawToken,
    );
    await storage.write(
      key: refreshStorageKey,
      value: result.refreshToken.rawToken,
    );

    return result.authenticationToken;
  }

  Future<void> signOut() async {
    await storage.delete(
      key: authenticationStorageKey,
    );
    await storage.delete(
      key: refreshStorageKey,
    );
  }
}
