import 'package:bark_authentication/src/utils/log.dart';
import 'package:dio/dio.dart';

final dio = Dio();

Future<void> callBarkInquiry() async {
  final Uri uri = Uri.https(
    'auth.bark.sh',
    '/inquiry',
  );

  final Response response = await dio.postUri(
    uri,
    data: {
      'domain': 'mipha.io',
      'actions': [
        {
          'type': 'callback',
          'payload': 'my-custom-app://test',
        },
      ],
    },
  );

  logger.debug(response.data);
}
