
import 'bark_authentication_platform_interface.dart';

class BarkAuthentication {
  Future<String?> getPlatformVersion() {
    return BarkAuthenticationPlatform.instance.getPlatformVersion();
  }
}
