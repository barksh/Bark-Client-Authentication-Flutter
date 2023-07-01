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

  BarkAuthenticationSignIn({
    required this.authenticatorDomain,
    required this.targetDomain,
  });

  Future<bool> signIn() async {
    final String? authenticationModuleDomain =
        await lookupAuthenticationModuleV1WithDNSProxy(
      authenticatorDomain,
    );

    if (authenticationModuleDomain == null) {
      return false;
    }

    final BarkInquiryResponse inquiryResponse = await callBarkInquiry(
      authenticationModuleDomain,
      targetDomain,
    );

    final String? authenticationUiDomain =
        await lookupAuthenticationUIV1WithDNSProxy(
      authenticatorDomain,
    );

    if (authenticationUiDomain == null) {
      return false;
    }

    final bool result = await openAuthenticationPortal(
      authenticationUiDomain,
      inquiryResponse.exposureKey,
    );

    final BarkRedeemResponse redeemResponse = await callBarkRedeem(
      inquiryResponse.hiddenKey,
    );

    final BarkRefreshToken refreshToken =
        BarkRefreshToken.fromRawToken(redeemResponse.refreshToken);

    logger.debug(refreshToken);

    return result;
  }
}
