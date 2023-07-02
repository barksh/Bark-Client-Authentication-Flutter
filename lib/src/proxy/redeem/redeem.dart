import 'package:dio/dio.dart';
import 'package:logo/logo.dart';

import '../client.dart';
import 'response.dart';

Future<BarkRedeemResponse> callBarkRedeem(
  final Uri baseUri,
  String hiddenKey, {
  required Logo logger,
}) async {
  final Uri uri = baseUri.resolve(
    '/v1/authentication/redeem',
  );

  try {
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
  } catch (e) {
    logger.error(e);
    rethrow;
  }
}
