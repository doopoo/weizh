//
//  UserViewController.h
//  TrafficQuery
//
//  Created by han zhen on 13-4-18.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginViewController;
@class IndexViewController;
@class NewPassword;
@interface UserViewController : UIViewController{
    NSDictionary* UserDic;
    UILabel* idLabel;
    UILabel* gradeLabel;
    UILabel* timeLabel;
    LoginViewController* loginViewController;
    IndexViewController* indexViewController;
    NewPassword* newPassword;
}
@property(nonatomic, retain)NSDictionary* UserDic;
@property(nonatomic, retain)IBOutlet UILabel* idLabel;
@property(nonatomic, retain)IBOutlet UILabel* gradeLabel;
@property(nonatomic, retain)IBOutlet UILabel* timeLabel;

-(IBAction)switchUser:(id)sender;
-(IBAction)goBack:(id)sender;
-(IBAction)changePwd:(id)sender;

@end
