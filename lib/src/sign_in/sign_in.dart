import 'package:bark/src/dns/authentication_module.dart';
import 'package:bark/src/dns/authentication_ui.dart';
import 'package:bark/src/proxy/inquiry/inquiry.dart';
import 'package:bark/src/proxy/inquiry/response.dart';
import 'package:bark/src/proxy/redeem/redeem.dart';
import 'package:bark/src/proxy/redeem/response.dart';
import 'package:bark/src/proxy/refresh/refresh.dart';
import 'package:bark/src/proxy/refresh/response.dart';
import 'package:bark/src/sign_in/result.dart';
import 'package:bark/src/sign_in/web_auth.dart';
import 'package:bark/src/token/authentication/authentication_token.dart';
import 'package:bark/src/token/refresh/refresh_token.dart';
import 'package:logo/logo.dart';

class BarkAuthenticationSignIn {
  final String authenticatorDomain;
  final String targetDomain;

  final Uri? overrideAuthenticationModuleDomain;
  final Uri? overrideAuthenticationUiDomain;

  final Logo logger;

  BarkAuthenticationSignIn({
    required this.authenticatorDomain,
    required this.targetDomain,
    this.overrideAuthenticationModuleDomain,
    this.overrideAuthenticationUiDomain,
    required this.logger,
  });

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

  Future<BarkAuthenticationToken?> refreshToken(
    BarkRefreshToken refreshToken,
  ) async {
    final Uri? authenticationModuleUri = await _getAuthenticationModuleDomain();

    if (authenticationModuleUri == null) {
      return null;
    }

    final BarkRefreshResponse refreshResponse = await callBarkRefresh(
      authenticationModuleUri,
      refreshToken.rawToken,
      logger: logger,
    );

    final BarkAuthenticationToken authenticationToken =
        BarkAuthenticationToken.fromRawToken(refreshResponse.token);

    return authenticationToken;
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
