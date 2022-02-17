#import "IdfaPlugin.h"
#import <AdSupport/ASIdentifierManager.h>
#import <AppTrackingTransparency/AppTrackingTransparency.h>

@implementation IdfaPlugin

- (void)getInfo:(CDVInvokedUrlCommand *)command {    
       NSLog(@"Call getInfo:");
       @try{ 
           [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                NSLog(@"Status: %lu", (unsigned long)status);
                CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsNSUInteger:status];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }];
        }@catch (NSException* exception) {
              CDVPluginResult* pluginResultErr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[exception reason]];  
              [self.commandDelegate sendPluginResult:pluginResultErr callbackId:command.callbackId];
        }
}

- (void)requestPermission:(CDVInvokedUrlCommand *)command {
    [self.commandDelegate runInBackground:^{
        if (@available(iOS 14, *)) {
            [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
                CDVPluginResult* pluginResult =
                    [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsNSUInteger:status];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
            }];
        } else {
            CDVPluginResult* pluginResult = [CDVPluginResult
                                             resultWithStatus:CDVCommandStatus_ERROR
                                             messageAsString:@"requestPermission is supported only for iOS >= 14"];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }
    }];
}

@end
