import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

import '../utils/log.dart';

Future<bool> openAuthenticationPortal(
  Uri baseUri,
  String exposureKey,
) async {
  try {
    logger.debug(
        "open authentication portal, uri: $baseUri, exposureKey: $exposureKey");

    final String result = await FlutterWebAuth2.authenticate(
      url: "https://${baseUri.authority}/?key=$exposureKey",
      callbackUrlScheme: "bark-callback",
    );

    if (result == "bark-callback://succeed") {
      return true;
    }

    logger.info(result);
    return false;
  } on PlatformException catch (e) {
    logger.error(e);
    return false;
  } catch (e) {
    logger.error(e);
    return false;
  }
}
