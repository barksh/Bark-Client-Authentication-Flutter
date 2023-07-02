import 'package:bark_authentication/bark_authentication.dart';
import 'package:flutter/material.dart';
import 'package:logo/logo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final BarkAuthenticationSignIn signIn = BarkAuthenticationSignIn(
      authenticatorDomain: "bark.sh",
      targetDomain: "example.flutter.authentication.client.bark.sh",
      overrideAuthenticationModuleDomain: Uri.http("localhost:4000"),
      logLevel: LogoLogLevel.all(),
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bark Client Authentication Example'),
        ),
        body: Center(
          child: ElevatedButton(
            child: const Text("Authenticate"),
            onPressed: () async {
              final BarkSignInResult? result = await signIn.signIn();

              if (result == null) {
                return;
              }
            },
          ),
        ),
      ),
    );
  }
}
