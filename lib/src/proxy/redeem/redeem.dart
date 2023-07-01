import 'package:dio/dio.dart';

import '../../utils/log.dart';
import '../client.dart';
import 'response.dart';

Future<BarkRedeemResponse> callBarkRedeem(
  final Uri baseUri,
  String hiddenKey,
) async {
  final Uri uri = baseUri.resolve(
    '/v1/authentication/redeem',
  );

  final Response rawResponse = await dio.postUri(
    uri,
    data: {
      'hiddenKey': hiddenKey,
    },
  );

  final BarkRedeemResponse response = BarkRedeemResponse.fromJson(
    rawResponse.data,
  );
  logger.debug(response);

  return response;
}
