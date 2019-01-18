#import "FlutterApplaunchPlugin.h"

@implementation FlutterApplaunchPlugin {
    NSDictionary* _launchOptions;
    NSDictionary* _launchUrlScheme;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_applaunch"
            binaryMessenger:[registrar messenger]];
  FlutterApplaunchPlugin* instance = [[FlutterApplaunchPlugin alloc] init];
  [registrar addApplicationDelegate:instance];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if([@"getAppLaunchURLScheme" isEqualToString:call.method]) {
      [self getAppLaunchURLScheme:call result:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)getAppLaunchURLScheme:(FlutterMethodCall*)call result:(FlutterResult)result {
    result(_launchUrlScheme);
}

#pragma mark - AppDelegate

- (BOOL)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    _launchOptions = launchOptions;
    NSMutableDictionary* scheme = [[NSMutableDictionary alloc] init];
    NSString *launchUrl = [_launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
    if (launchUrl) {
        [scheme setObject:[NSString stringWithFormat:@"%@", launchUrl] forKey:@"url"];
    }
    
    NSString *sourceApplication = [_launchOptions objectForKey:UIApplicationLaunchOptionsSourceApplicationKey];
    if (sourceApplication) {
        [scheme setObject:[NSString stringWithFormat:@"%@", sourceApplication] forKey:@"source"];
    }
    _launchUrlScheme = [[NSDictionary alloc] initWithDictionary:scheme];
    return YES;
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    _launchUrlScheme = [[NSDictionary alloc] initWithObjectsAndKeys:url.absoluteString, @"url", nil];
    return YES;
}

-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    NSMutableDictionary* scheme = [[NSMutableDictionary alloc] initWithObjectsAndKeys:url.absoluteString, @"url", nil];
    if (@available(iOS 9.0, *)) {
        NSString *sourceApplication = [options objectForKey:UIApplicationOpenURLOptionsSourceApplicationKey];
        if (sourceApplication) {
            [scheme setObject:[NSString stringWithFormat:@"%@", sourceApplication] forKey:@"source"];
        }
    }
    _launchUrlScheme = [[NSDictionary alloc] initWithDictionary:scheme];
    return YES;
}
@end
