#import "KustomerPlugin.h"
#if __has_include(<kustomer_native_plugin/kustomer_native_plugin-Swift.h>)
#import <kustomer_native_plugin/kustomer_native_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "kustomer_native_plugin-Swift.h"
#endif

@implementation KustomerPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [KustomerNativePlugin registerWithRegistrar:registrar];
}
@end