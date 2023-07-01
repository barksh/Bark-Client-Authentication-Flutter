import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'platform_method_channel.dart';

abstract class BarkAuthenticationPlatform extends PlatformInterface {
  /// Constructs a BarkAuthenticationPlatform.
  BarkAuthenticationPlatform() : super(token: _token);

  static final Object _token = Object();

  static BarkAuthenticationPlatform _instance =
      MethodChannelBarkAuthentication();

  /// The default instance of [BarkAuthenticationPlatform] to use.
  ///
  /// Defaults to [MethodChannelBarkAuthentication].
  static BarkAuthenticationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [BarkAuthenticationPlatform] when
  /// they register themselves.
  static set instance(BarkAuthenticationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
