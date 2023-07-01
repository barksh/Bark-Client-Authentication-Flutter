import 'package:dio/dio.dart';

import '../../utils/log.dart';
import '../client.dart';
import 'response.dart';

Future<BarkRedeemResponse> callBarkRedeem(
  String hiddenKey,
) async {
  final Uri uri = Uri.http(
    'localhost:4000',
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
