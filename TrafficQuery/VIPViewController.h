//
//  VIPViewController.h
//  TrafficQuery
//
//  Created by hz on 13-5-3.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RemindViewController;
@class UpgradeViewController;

@interface VIPViewController : UIViewController{
    RemindViewController* remindViewController;
    UpgradeViewController* upgradeViewController;
}
-(IBAction)goBack:(id)sender;
-(IBAction)upgrade:(id)sender;
@end
