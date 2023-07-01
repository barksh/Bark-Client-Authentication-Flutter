import 'package:bark_authentication/src/proxy/inquiry/response.dart';
import 'package:bark_authentication/src/sign_in/web_auth.dart';

import '../dns/authentication_module.dart';
import '../proxy/inquiry/inquiry.dart';

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

    final bool result = await openAuthenticationPortal(
      authenticatorDomain,
      inquiryResponse.exposureKey,
    );

    return result;
  }
}
