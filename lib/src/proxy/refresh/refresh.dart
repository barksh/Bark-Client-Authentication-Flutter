import 'package:dio/dio.dart';

import '../../utils/log.dart';
import '../client.dart';
import 'response.dart';

Future<BarkRefreshResponse> callBarkRefresh(
  final Uri baseUri,
  String refreshToken,
) async {
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

    final BarkRefreshResponse response = BarkRefreshResponse.fromJson(
      rawResponse.data,
    );
    logger.debug(response);

    return response;
  } catch (e) {
    logger.error(e);
    rethrow;
  }
}
