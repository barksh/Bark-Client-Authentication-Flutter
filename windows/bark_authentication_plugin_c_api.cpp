#include "include/bark_authentication/bark_authentication_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "bark_authentication_plugin.h"

void BarkAuthenticationPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  bark_authentication::BarkAuthenticationPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
