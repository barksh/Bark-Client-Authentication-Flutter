import 'package:dio/dio.dart';

import '../../utils/log.dart';
import '../client.dart';
import 'response.dart';

Future<BarkInquiryResponse> callBarkInquiry() async {
  final Uri uri = Uri.http(
    'localhost:4000',
    '/v1/authentication/inquiry',
  );

  final Response rawResponse = await dio.postUri(
    uri,
    data: {
      'domain': 'mipha.io',
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
}
