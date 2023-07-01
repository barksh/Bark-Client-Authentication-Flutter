import 'package:bark_authentication/src/proxy/inquiry/response.dart';
import 'package:bark_authentication/src/proxy/redeem/response.dart';
import 'package:bark_authentication/src/sign_in/web_auth.dart';
import 'package:bark_authentication/src/token/refresh/refresh_token.dart';
import 'package:bark_authentication/src/utils/log.dart';

import '../dns/authentication_module.dart';
import '../dns/authentication_ui.dart';
import '../proxy/inquiry/inquiry.dart';
import '../proxy/redeem/redeem.dart';

class BarkAuthenticationSignIn {
  final String authenticatorDomain;
  final String targetDomain;

  final Uri? overrideAuthenticationModuleDomain;
  final Uri? overrideAuthenticationUiDomain;

  BarkAuthenticationSignIn({
    required this.authenticatorDomain,
    required this.targetDomain,
    this.overrideAuthenticationModuleDomain,
    this.overrideAuthenticationUiDomain,
  });

  Future<bool> signIn() async {
    final Uri? authenticationModuleUri = await _getAuthenticationModuleDomain();

    if (authenticationModuleUri == null) {
      return false;
    }

    final BarkInquiryResponse inquiryResponse = await callBarkInquiry(
      authenticationModuleUri,
      targetDomain,
    );

    final Uri? authenticationUiDomain = await _getAuthenticationUIDomain();

    if (authenticationUiDomain == null) {
      return false;
    }

    final bool result = await openAuthenticationPortal(
      authenticationUiDomain,
      inquiryResponse.exposureKey,
    );

    if (!result) {
      return false;
    }

    final BarkRedeemResponse redeemResponse = await callBarkRedeem(
      authenticationModuleUri,
      inquiryResponse.hiddenKey,
    );

    final BarkRefreshToken refreshToken =
        BarkRefreshToken.fromRawToken(redeemResponse.refreshToken);

    logger.debug(refreshToken);

    return result;
  }

  Future<Uri?> _getAuthenticationModuleDomain() async {
    if (overrideAuthenticationModuleDomain != null) {
      return overrideAuthenticationModuleDomain;
    }

    final String? authenticationModuleDomain =
        await lookupAuthenticationModuleV1WithDNSProxy(
      authenticatorDomain,
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
