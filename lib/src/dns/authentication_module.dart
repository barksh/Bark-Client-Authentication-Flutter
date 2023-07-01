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

  return cnameRecord.first.data;
}
