import 'dart:convert';

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

    logger.verbose("Bark - Redeem Proxy Response: $rawResponse");

    final BarkRedeemResponse response = BarkRedeemResponse.fromJson(
      rawResponse.data is String
          ? jsonDecode(rawResponse.data)
          : rawResponse.data,
    );
    logger.debug(response);

    return response;
  } on DioException catch (e) {
    logger.error(e);
    logger.error(e.response?.data);
    rethrow;
  } catch (e) {
    logger.error(e);
    rethrow;
  }
}
