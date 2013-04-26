//
//  AppDelegate.m
//  TrafficQuery
//
//  Created by hz on 13-3-26.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate
@synthesize firstLaunch;
@synthesize homeIntroduce;
@synthesize navigationController, window;


- (void)dealloc
{
    [navigationController release];
    [window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //设置并存储判断值，记录程序是否是第一次进入
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]){//如果不是第一次
        NSLog(@"everLaunched = %d",[[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]);
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunced"];
    }
    
//    self.window.backgroundColor = [UIColor blackColor];
//    application.statusBarStyle = UIStatusBarStyleBlackOpaque;
    [window addSubview:navigationController.view];
    
    [WXApi registerApp:@"wx1776876183a5c08f"];
    
    self.firstLaunch = YES;
    
    
   [self addHomeIntroduceWithLogoutStatus:NO];
    
    
//  NSLog(@"everLaunched再一次 = %d",[[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]);
    [self.window makeKeyAndVisible];
    
    return YES;
}

-(void)onReq:(BaseReq *)req
{
    
}
-(void)onResp:(BaseResp *)resp
{
    
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [WXApi handleOpenURL:url delegate:self];
}


-(void)addHomeIntroduceWithLogoutStatus:(BOOL)bLogout{
  
    if (nil != homeIntroduce)
    {
        [homeIntroduce release];
        homeIntroduce = nil;
    }
    homeIntroduce = [[HomeIntroduce alloc] init];
   // homeIntroduce = [[HomeIntroduce alloc] initWithNibName:@"HomeIntroduce" bundle:nil];
   //iphone5
    homeIntroduce.view.frame = CGRectMake(0, 20, 320, 460);//320*480
    AppDelegate* del = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    del.window.backgroundColor = [UIColor blackColor];
    
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:homeIntroduce];
    self.window.rootViewController = nav;
    [nav setNavigationBarHidden:TRUE];
    
    
    //[self.window addSubview:homeIntroduce.view];
    

   [nav release];
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
