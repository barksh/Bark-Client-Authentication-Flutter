import 'package:bark_authentication/src/utils/log.dart';
import 'package:basic_utils/basic_utils.dart';

const String dnsRecordName = '_bark-module-authentication-v1';

Future<String?> lookupAuthenticationModuleV1WithDNSProxy(
  String authenticatorDomain,
) async {
  final String authenticationModuleDNSDomain =
      "$dnsRecordName.$authenticatorDomain";

  final List<RRecord>? cnameRecord = await DnsUtils.lookupRecord(
    authenticationModuleDNSDomain,
    RRecordType.CNAME,
  );

  if (cnameRecord == null) {
    return null;
  }

  if (cnameRecord.isEmpty) {
    return null;
  }

  final String dnsResponse = cnameRecord.first.data;
  logger.debug("lookup DNS Record for Authentication Module: $dnsResponse");

  if (dnsResponse.endsWith('.')) {
    return dnsResponse.substring(0, dnsResponse.length - 1);
  }

  return dnsResponse;
}
