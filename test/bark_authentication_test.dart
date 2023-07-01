import 'package:flutter_test/flutter_test.dart';
import 'package:bark_authentication/bark_authentication.dart';
import 'package:bark_authentication/bark_authentication_platform_interface.dart';
import 'package:bark_authentication/bark_authentication_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockBarkAuthenticationPlatform
    with MockPlatformInterfaceMixin
    implements BarkAuthenticationPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final BarkAuthenticationPlatform initialPlatform = BarkAuthenticationPlatform.instance;

  test('$MethodChannelBarkAuthentication is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelBarkAuthentication>());
  });

  test('getPlatformVersion', () async {
    BarkAuthentication barkAuthenticationPlugin = BarkAuthentication();
    MockBarkAuthenticationPlatform fakePlatform = MockBarkAuthenticationPlatform();
    BarkAuthenticationPlatform.instance = fakePlatform;

    expect(await barkAuthenticationPlugin.getPlatformVersion(), '42');
  });
}
