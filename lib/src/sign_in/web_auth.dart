import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

void startWebAuth() async {
  await FlutterWebAuth2.authenticate(
    url: "https://auth.bark.sh",
    callbackUrlScheme: "my-custom-app",
  );
}
