import 'package:bark/bark.dart';
import 'package:flutter/material.dart';
import 'package:logo/logo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final BarkAuthentication signIn = BarkAuthentication(
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
          child: Builder(
            builder: (BuildContext context) {
              return Column(
                children: [
                  ElevatedButton(
                    child: const Text("Authenticate"),
                    onPressed: () {
                      signIn.signIn().then((BarkSignInResult? result) {
                        if (result == null) {
                          return;
                        }

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Authentication Result"),
                              content: Text(result.toString()),
                              actions: [
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                    },
                  ),
                  ElevatedButton(
                    child: const Text("Get Authentication Token"),
                    onPressed: () {
                      signIn
                          .getAuthenticationToken()
                          .then((BarkAuthenticationToken? result) {
                        if (result == null) {
                          return;
                        }

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Get Authentication Result"),
                              content: Text(result.toString()),
                              actions: [
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                    },
                  ),
                  ElevatedButton(
                    child: const Text("Get Refresh Token"),
                    onPressed: () {
                      signIn.getRefreshToken().then((BarkRefreshToken? result) {
                        if (result == null) {
                          return;
                        }

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Get Refresh Result"),
                              content: Text(result.toString()),
                              actions: [
                                TextButton(
                                  child: const Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      });
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
