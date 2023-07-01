import 'package:dio/dio.dart';

import '../../utils/log.dart';
import '../client.dart';
import 'response.dart';

Future<BarkRefreshResponse> callBarkRedeem(
  String refreshToken,
) async {
  final Uri uri = Uri.http(
    'localhost:4000',
    '/v1/authentication/refresh',
  );

  final Response rawResponse = await dio.postUri(
    uri,
    data: {
      'refreshToken': refreshToken,
    },
  );

  final BarkRefreshResponse response = BarkRefreshResponse.fromJson(
    rawResponse.data,
  );
  logger.debug(response);

  return response;
}
