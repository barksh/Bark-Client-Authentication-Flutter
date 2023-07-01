import 'package:bark_authentication/src/utils/log.dart';
import 'package:dio/dio.dart';

final dio = Dio();

Future<void> callBarkInquiry() async {
  final Uri uri = Uri.http(
    'localhost:4000',
    '/v1/authentication/inquiry',
  );

  final Response response = await dio.postUri(
    uri,
    data: {
      'domain': 'mipha.io',
      'actions': [
        {
          'type': 'CALLBACK',
          'payload': 'my-custom-app://test',
        },
      ],
    },
  );

  logger.debug(response.data);
}
