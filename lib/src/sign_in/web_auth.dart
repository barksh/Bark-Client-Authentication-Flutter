import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

import '../proxy/inquiry.dart';
import '../utils/log.dart';

void startWebAuth() async {
  try {
    logger.info('startWebAuth');

    await callBarkInquiry();
    final String result = await FlutterWebAuth2.authenticate(
      url: "https://auth.bark.sh/?key=d9d38e90f99e74cbfe79c68b6dbc3768",
      callbackUrlScheme: "bark-callback",
    );

    logger.info(result);
  } on PlatformException catch (e) {
    logger.error(e);
  } catch (e) {
    logger.error(e);
  }
}
