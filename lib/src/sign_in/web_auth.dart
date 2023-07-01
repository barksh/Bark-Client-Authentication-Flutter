import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

import '../proxy/inquiry.dart';
import '../utils/log.dart';

void startWebAuth() async {
  try {
    logger.info('startWebAuth');

    await callBarkInquiry();
    await FlutterWebAuth2.authenticate(
      url: "https://auth.bark.sh",
      callbackUrlScheme: "my-custom-app",
    );
  } on PlatformException catch (e) {
    logger.error(e);
  } catch (e) {
    logger.error(e);
  }
}
