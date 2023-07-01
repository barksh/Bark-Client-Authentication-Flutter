#ifndef FLUTTER_PLUGIN_BARK_AUTHENTICATION_PLUGIN_H_
#define FLUTTER_PLUGIN_BARK_AUTHENTICATION_PLUGIN_H_

#include <flutter_linux/flutter_linux.h>

G_BEGIN_DECLS

#ifdef FLUTTER_PLUGIN_IMPL
#define FLUTTER_PLUGIN_EXPORT __attribute__((visibility("default")))
#else
#define FLUTTER_PLUGIN_EXPORT
#endif

typedef struct _BarkAuthenticationPlugin BarkAuthenticationPlugin;
typedef struct {
  GObjectClass parent_class;
} BarkAuthenticationPluginClass;

FLUTTER_PLUGIN_EXPORT GType bark_authentication_plugin_get_type();

FLUTTER_PLUGIN_EXPORT void bark_authentication_plugin_register_with_registrar(
    FlPluginRegistrar* registrar);

G_END_DECLS

#endif  // FLUTTER_PLUGIN_BARK_AUTHENTICATION_PLUGIN_H_
