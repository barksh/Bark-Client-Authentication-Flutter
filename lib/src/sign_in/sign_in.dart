import 'package:bark_authentication/src/proxy/inquiry/response.dart';
import 'package:bark_authentication/src/proxy/redeem/response.dart';
import 'package:bark_authentication/src/proxy/refresh/response.dart';
import 'package:bark_authentication/src/sign_in/result.dart';
import 'package:bark_authentication/src/sign_in/web_auth.dart';
import 'package:bark_authentication/src/token/authentication/authentication_token.dart';
import 'package:bark_authentication/src/token/refresh/refresh_token.dart';
import 'package:logo/logo.dart';

import '../dns/authentication_module.dart';
import '../dns/authentication_ui.dart';
import '../proxy/inquiry/inquiry.dart';
import '../proxy/redeem/redeem.dart';
import '../proxy/refresh/refresh.dart';

class BarkAuthenticationSignIn {
  final String authenticatorDomain;
  final String targetDomain;

  final Uri? overrideAuthenticationModuleDomain;
  final Uri? overrideAuthenticationUiDomain;

  late final Logo logger;

  BarkAuthenticationSignIn({
    required this.authenticatorDomain,
    required this.targetDomain,
    this.overrideAuthenticationModuleDomain,
    this.overrideAuthenticationUiDomain,
    LogoLogLevel? logLevel,
  }) {
    logger = Logo(logLevel ?? LogoLogLevel.info());
  }

  Future<BarkSignInResult?> signIn() async {
    final Uri? authenticationModuleUri = await _getAuthenticationModuleDomain();

    if (authenticationModuleUri == null) {
      return null;
    }

    final BarkInquiryResponse inquiryResponse = await callBarkInquiry(
      authenticationModuleUri,
      targetDomain,
      logger: logger,
    );

    final Uri? authenticationUiDomain = await _getAuthenticationUIDomain();

    if (authenticationUiDomain == null) {
      return null;
    }

    final bool result = await openAuthenticationPortal(
      authenticationUiDomain,
      inquiryResponse.exposureKey,
      logger: logger,
    );

    if (!result) {
      return null;
    }

    final BarkRedeemResponse redeemResponse = await callBarkRedeem(
      authenticationModuleUri,
      inquiryResponse.hiddenKey,
      logger: logger,
    );

    final BarkRefreshToken refreshToken =
        BarkRefreshToken.fromRawToken(redeemResponse.refreshToken);

    final BarkRefreshResponse refreshResponse = await callBarkRefresh(
      authenticationModuleUri,
      refreshToken.rawToken,
      logger: logger,
    );

    final BarkAuthenticationToken authenticationToken =
        BarkAuthenticationToken.fromRawToken(refreshResponse.token);

    return BarkSignInResult(
      refreshToken: refreshToken,
      authenticationToken: authenticationToken,
    );
  }

  Future<Uri?> _getAuthenticationModuleDomain() async {
    if (overrideAuthenticationModuleDomain != null) {
      return overrideAuthenticationModuleDomain;
    }

    final String? authenticationModuleDomain =
        await lookupAuthenticationModuleV1WithDNSProxy(
      authenticatorDomain,
      logger: logger,
    );

    if (authenticationModuleDomain == null) {
      return null;
    }

    final Uri uri = Uri.https(
      authenticationModuleDomain,
    );

    return uri;
  }

  Future<Uri?> _getAuthenticationUIDomain() async {
    if (overrideAuthenticationUiDomain != null) {
      return overrideAuthenticationUiDomain;
    }

    final String? authenticationUIDomain =
        await lookupAuthenticationUIV1WithDNSProxy(
      authenticatorDomain,
      logger: logger,
    );

    if (authenticationUIDomain == null) {
      return null;
    }

    final Uri uri = Uri.https(
      authenticationUIDomain,
    );

    return uri;
  }
}
