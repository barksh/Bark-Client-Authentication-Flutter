import 'package:bark_authentication/src/platform/platform_interface.dart';

class BarkAuthentication {
  Future<String?> getPlatformVersion() {
    return BarkAuthenticationPlatform.instance.getPlatformVersion();
  }
}
