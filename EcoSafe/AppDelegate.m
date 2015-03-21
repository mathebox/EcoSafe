//
//  AppDelegate.m
//  EcoSafe
//
//  Created by Max Bothe on 21/03/15.
//  Copyright (c) 2015 Max Bothe. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    NSURL* url = [launchOptions objectForKey:UIApplicationLaunchOptionsURLKey];
    [MySpinServerSDK sharedInstance].delegate = self;
    [[MySpinServerSDK sharedInstance] setLaunchURL:url];
    [[MySpinServerSDK sharedInstance] start];
#if DEBUG
    // TCP ScreenCopy capability is not allowed in final products. You can keep it enabled until you send in your app for review.
    [[MySpinServerSDK sharedInstance] addCapability:Capability_TCP_ScreenCopy];
#endif
    [[MySpinServerSDK sharedInstance] addCapability:Capability_EAF];

    // set the log level
    [[MySpinServerSDK sharedInstance] setLogLevel:LogLevel_Fatal];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (UIViewController*)viewControllerForDisconnectedMode
{
    // Return a view controller that is visible on the device when it is not connected to the IVI.
    // This can either be a "please connect to the IVI" screen or the regular functional application.
    // The view controller is retained by the SDK.

    // DisconnectedViewController *disconnectedViewController = [[DisconnectedViewController alloc] init];
    UIViewController *disconnectedViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    return disconnectedViewController;
}


- (UIViewController*)viewControllerForConnectedModeOnRemoteScreen:(CGSize)remoteScreenSize
{
    // Return a view controller that is supposed to be visible on the IVI screen.
    // The view controller is retained by the SDK.

    // ConnectedViewController *connectedViewController = [[ConnectedViewController alloc] initWithNibName:@"ConnectedViewController" bundle:nil];
    UIViewController* connectedViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    return connectedViewController;
}

// The function will be called whenever the app was started (or brought back to the foreground, if already running) with an URL scheme parameter.
// This function is required to ensure that the app can connect to the IVI when it was already running in the background when opened from the app launcher
- (BOOL)application:(UIApplication*)application openURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication annotation:(id)annotation
{
    [[MySpinServerSDK sharedInstance] setLaunchURL:url];

    return YES;
}


@end
