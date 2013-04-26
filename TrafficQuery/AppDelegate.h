//
//  AppDelegate.h
//  TrafficQuery
//
//  Created by hz on 13-3-26.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeIntroduce.h"

#import "WXApi.h"

@interface AppDelegate : NSObject <UIApplicationDelegate,WXApiDelegate>{
    BOOL firstLanch;//是否是第一次启动
    
    UIWindow* window;
    UINavigationController* navigationController;
    
    HomeIntroduce* homeIntroduce;
    enum WXScene _scene;
   
}

@property (retain, nonatomic)IBOutlet UIWindow *window;
@property (retain, nonatomic)IBOutlet UINavigationController* navigationController;
@property (assign, nonatomic)BOOL firstLaunch;
@property (retain, nonatomic)HomeIntroduce* homeIntroduce;

-(void)addHomeIntroduceWithLogoutStatus:(BOOL)bLogout;
@end