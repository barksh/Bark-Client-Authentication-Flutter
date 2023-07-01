import 'package:bark_authentication/src/utils/log.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

void startWebAuth() async {
  try {
    await FlutterWebAuth2.authenticate(
      url: "https://auth.bark.sh",
      callbackUrlScheme: "my-custom-app",
    );
  } on PlatformException catch (e) {
    logger.debug(e);
  } catch (e) {
    logger.debug(e);
  }
}
