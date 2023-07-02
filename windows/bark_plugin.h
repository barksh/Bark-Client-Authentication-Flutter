#ifndef FLUTTER_PLUGIN_BARK_PLUGIN_H_
#define FLUTTER_PLUGIN_BARK_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace bark {

class BarkPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  BarkPlugin();

  virtual ~BarkPlugin();

  // Disallow copy and assign.
  BarkPlugin(const BarkPlugin&) = delete;
  BarkPlugin& operator=(const BarkPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace bark

#endif  // FLUTTER_PLUGIN_BARK_PLUGIN_H_
