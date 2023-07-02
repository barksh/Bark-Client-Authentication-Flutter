import 'package:flutter/services.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:logo/logo.dart';

Future<bool> openAuthenticationPortal(
  Uri baseUri,
  String exposureKey, {
  required Logo logger,
}) async {
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
    return false;
  } on PlatformException catch (e) {
    logger.error(e);
    return false;
  } catch (e) {
    logger.error(e);
    return false;
  }
}
