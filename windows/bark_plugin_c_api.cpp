#include "include/bark/bark_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "bark_plugin.h"

void BarkPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  bark::BarkPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
