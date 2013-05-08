//
//  AppDelegate.m
//  TrafficQuery
//
//  Created by hz on 13-3-26.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "AppDelegate.h"
#import "IndexViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@implementation AppDelegate
@synthesize firstLaunch;
@synthesize homeIntroduce;
@synthesize  window;


- (void)dealloc
{
    [window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //设置并存储判断值，记录程序是否是第一次进入

    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]){//如果不是第一次
        NSLog(@"everLaunched = %d",[[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]);
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    else{
        NSLog(@"everLaunched2 = %d",[[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]);
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
        // [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunced"];
    }
    
//    self.window.backgroundColor = [UIColor blackColor];
//    application.statusBarStyle = UIStatusBarStyleBlackOpaque;
//    [window addSubview:navigationController.view];
    
    [WXApi registerApp:@"wx1776876183a5c08f"];
    
    self.firstLaunch = YES;
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [self addHomeIntroduceWithLogoutStatus:NO];
    }else{
        indexViewController = [[[IndexViewController alloc] init] initWithNibName:@"IndexViewController" bundle:nil];
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:indexViewController];
        self.window.rootViewController = nav;
        [nav setNavigationBarHidden:TRUE];
    }
    
    
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
    CGFloat screenHeight = [[UIScreen mainScreen]bounds].size.height;
    homeIntroduce.view.frame = CGRectMake(0, 0, 320, screenHeight-20);//320*480
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
//改写
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    

    
    
    
    
    
  while([application backgroundTimeRemaining] > 1.0){
    
        /*
        NSString* urlString = [NSString stringWithFormat:@"http://116.255.238.8:3000/querytraffic"];
        ASIFormDataRequest* requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];

        [requestForm setPostValue:@"2013-02-01" forKey:@"date_s"];
        [requestForm setPostValue:@"豫AGM979" forKey:@"hphm"];
         [requestForm setPostValue:@"428163" forKey:@"clsbdh"];
        [requestForm setPostValue:@"02" forKey:@"hpzl"];
        [requestForm setPostValue:@"VS" forKey:@"queryid"];
        // 设定委托，委托自己实现异步请求方法
        [requestForm setDelegate:self];

        [requestForm startSynchronous];

        
        NSString* str = [[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding];
        
        NSLog(@"str = %@",str);*/
        
        
       
        //创建一个本地推送
        UILocalNotification* localNotif = [[UILocalNotification alloc] init];
        if (localNotif){
            /*
            NSString* urlString = [NSString stringWithFormat:@"http://116.255.238.8:3000/querytraffic"];
            ASIFormDataRequest* requestForm = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
            
            [requestForm setPostValue:@"2013-02-01" forKey:@"date_s"];
            [requestForm setPostValue:@"豫AGM979" forKey:@"hphm"];
            [requestForm setPostValue:@"428163" forKey:@"clsbdh"];
            [requestForm setPostValue:@"02" forKey:@"hpzl"];
            [requestForm setPostValue:@"VS" forKey:@"queryid"];
            // 设定委托，委托自己实现异步请求方法
            [requestForm setDelegate:self];
            
            [requestForm startSynchronous];
           
            
            NSString* str = [[NSString alloc] initWithData:[requestForm responseData] encoding:NSUTF8StringEncoding];
            
            NSLog(@"str = %@",str);
             */
            
            
            
            
            
            //            NSTimeInterval secondsPerDay = 48*60*60;
            //             NSTimeInterval secondsPerDay = 48*60*60;
            NSTimeInterval secondsPerDay = 48*60*60;
            NSDate* ttomorrow = [[NSDate alloc] initWithTimeIntervalSinceNow:secondsPerDay];
            //设置推送时间
            localNotif.fireDate = ttomorrow;
            
            
            
            
            //设置时区
            localNotif.timeZone = [NSTimeZone defaultTimeZone];
            //设置重复间隔
            //  [localNotif setRepeatInterval:NSWeekCalendarUnit];
            [localNotif setRepeatInterval:NSDayCalendarUnit];
            //显示在icon上的红色圈中的数字
            //-   localNotif.applicationIconBadgeNumber = 1;
            // Notification details
            //内容
//            localNotif.alertBody = @"河南违章查询!~~(╯_╰)";
            
            
            
            
            localNotif.alertBody = @"有新违章记录，请点击查看!";
            // Set the action button
            localNotif.alertAction = @"我要去!";
            //推送声音
            localNotif.soundName = UILocalNotificationDefaultSoundName;
            
            // Specify custom data for the notification
            //设置userinfo方便在之后需要撤销的时候使用
            NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
            localNotif.userInfo = infoDict;
            
            // Schedule the notification
            //添加推送到UIApplication
            [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
            [localNotif release];
            break;
            
        }
    }
    
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
