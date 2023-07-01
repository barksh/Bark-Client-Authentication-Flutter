import 'package:bark_authentication/src/proxy/inquiry/response.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

import '../proxy/inquiry/inquiry.dart';
import '../utils/log.dart';

void startWebAuth() async {
  try {
    logger.info('startWebAuth');

    final BarkInquiryResponse inquiryResponse = await callBarkInquiry();
    final String result = await FlutterWebAuth2.authenticate(
      url: "https://auth.bark.sh/?key=${inquiryResponse.exposureKey}",
      callbackUrlScheme: "bark-callback",
    );

    logger.info(result);
  } on PlatformException catch (e) {
    logger.error(e);
  } catch (e) {
    logger.error(e);
  }
}
