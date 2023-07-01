import 'package:bark_authentication/src/utils/log.dart';
import 'package:http/http.dart' as http;

Future<void> callBarkInquiry() async {
  final Uri uri = Uri.https(
    'auth.bark.sh',
    '/inquiry',
  );

  final http.Response response = await http.post(
    uri,
    body: {
      'domain': 'mipha.io',
      'actions': [
        {
          'type': 'callback',
          'payload': 'my-custom-app://test',
        },
      ],
    },
  );

  logger.debug(response.body);
}
