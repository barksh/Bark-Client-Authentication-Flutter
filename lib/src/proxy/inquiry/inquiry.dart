import 'package:dio/dio.dart';

import '../../utils/log.dart';
import '../client.dart';
import 'response.dart';

Future<BarkInquiryResponse> callBarkInquiry(
  final Uri baseUri,
  final String targetDomain,
) async {
  final Uri uri = baseUri.resolve(
    '/v1/authentication/inquiry',
  );

  try {
    final Response rawResponse = await dio.postUri(
      uri,
      data: {
        'domain': targetDomain,
        'actions': [
          {
            'type': 'CALLBACK',
            'payload': 'bark-callback://succeed',
          },
        ],
      },
    );

    final BarkInquiryResponse response = BarkInquiryResponse.fromJson(
      rawResponse.data,
    );
    logger.debug(response);

    return response;
  } catch (e) {
    logger.error(e);
    rethrow;
  }
}
