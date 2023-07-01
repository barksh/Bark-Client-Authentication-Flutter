import 'dart:io';

import 'package:bark_authentication/src/utils/log.dart';

Future<String> lookupAuthenticationModuleV1WithDNSProxy(
  String authenticatorDomain,
) async {
  final List<InternetAddress> addresses = await InternetAddress.lookup(
    authenticatorDomain,
    type: InternetAddressType.IPv4,
  );

  logger.debug(addresses);

  return "";
}
