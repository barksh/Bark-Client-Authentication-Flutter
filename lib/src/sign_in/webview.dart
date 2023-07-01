import 'package:webview_flutter/webview_flutter.dart';

WebViewController createSignInWebview() {
  const PlatformWebViewControllerCreationParams params =
      PlatformWebViewControllerCreationParams();

  final WebViewController controller =
      WebViewController.fromPlatformCreationParams(params);

  return controller;
}
