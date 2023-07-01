import 'package:bark_authentication/src/proxy/inquiry/response.dart';
import 'package:bark_authentication/src/sign_in/web_auth.dart';

import '../proxy/inquiry/inquiry.dart';

class BarkAuthenticationSignIn {
  final String authenticatorDomain;
  final String targetDomain;

  BarkAuthenticationSignIn({
    required this.authenticatorDomain,
    required this.targetDomain,
  });

  Future<bool> signIn() async {
    final BarkInquiryResponse inquiryResponse = await callBarkInquiry(
      authenticatorDomain,
      targetDomain,
    );

    final bool result = await openAuthenticationPortal(
      authenticatorDomain,
      inquiryResponse.exposureKey,
    );

    return result;
  }
}
