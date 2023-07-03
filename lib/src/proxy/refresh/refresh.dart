import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:logo/logo.dart';

import '../client.dart';
import 'response.dart';

Future<BarkRefreshResponse> callBarkRefresh(
  final Uri baseUri,
  String refreshToken, {
  required Logo logger,
}) async {
  final Uri uri = baseUri.resolve(
    '/v1/authentication/refresh',
  );

  try {
    final Response rawResponse = await dio.postUri(
      uri,
      data: {
        'refreshToken': refreshToken,
      },
    );

    logger.verbose("Bark - Refresh Proxy Response: $rawResponse");

    final BarkRefreshResponse response = BarkRefreshResponse.fromJson(
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
