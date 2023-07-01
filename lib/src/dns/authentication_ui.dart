import 'package:basic_utils/basic_utils.dart';

const String dnsRecordName = '_bark-ui-authentication-v1';

Future<String?> lookupAuthenticationUIV1WithDNSProxy(
  String authenticatorDomain,
) async {
  final String authenticationUiDNSDomain =
      "$dnsRecordName.$authenticatorDomain";

  final List<RRecord>? cnameRecord = await DnsUtils.lookupRecord(
    authenticationUiDNSDomain,
    RRecordType.CNAME,
  );

  if (cnameRecord == null) {
    return null;
  }

  if (cnameRecord.isEmpty) {
    return null;
  }

  final String dnsResponse = cnameRecord.first.data;

  if (dnsResponse.endsWith('.')) {
    return dnsResponse.substring(0, dnsResponse.length - 1);
  }

  return dnsResponse;
}
