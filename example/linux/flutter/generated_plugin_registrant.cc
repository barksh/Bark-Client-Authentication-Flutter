//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <bark_authentication/bark_authentication_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) bark_authentication_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "BarkAuthenticationPlugin");
  bark_authentication_plugin_register_with_registrar(bark_authentication_registrar);
}
