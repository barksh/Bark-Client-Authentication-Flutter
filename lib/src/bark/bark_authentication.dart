import 'package:logo/logo.dart';

class BarkAuthentication {
  final String authenticatorDomain;
  final String targetDomain;

  final Uri? overrideAuthenticationModuleDomain;
  final Uri? overrideAuthenticationUiDomain;

  late final Logo logger;

  BarkAuthentication({
    required this.authenticatorDomain,
    required this.targetDomain,
    this.overrideAuthenticationModuleDomain,
    this.overrideAuthenticationUiDomain,
    LogoLogLevel? logLevel,
  }) {
    logger = Logo(logLevel ?? LogoLogLevel.info());
  }
}
