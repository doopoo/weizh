//
//  UserViewController.m
//  TrafficQuery
//
//  Created by han zhen on 13-4-18.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import "UserViewController.h"
#import "CarManager.h"
#import "LoginViewController.h"
#import "IndexViewController.h"
#import "NewPassword.h"
#define USERFILEPATH [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/User.plist"]
@interface UserViewController ()

@end

@implementation UserViewController
@synthesize idLabel, gradeLabel, timeLabel;
@synthesize UserDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [CarManager sharedInstance].isLogin = YES;
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasLogin"];
    UserDic = [[NSDictionary alloc] initWithContentsOfFile:USERFILEPATH];
    self.idLabel.text = [UserDic objectForKey:@"userID"];
    
    if([[UserDic objectForKey:@"flag"] isEqualToString:@"1"]){//付费用户
        NSLog(@"调用了1");
        if([[UserDic objectForKey:@"payType"] isEqualToString:@"2"])
        {//短信付费
            if([[UserDic objectForKey:@"status"] isEqualToString:@"1"])
            {//确定是会员
                self.gradeLabel.text = @"VIP会员";
                if([[UserDic objectForKey:@"end"] isEqualToString:@""])
                {
                    self.timeLabel.text = @"永久";
                }else
                {
                    self.timeLabel.text = [UserDic objectForKey:@"end"];
                }
            }else if([[UserDic objectForKey:@"status"] isEqualToString:@"0"])
            {//不确定是会员，需判断时间
                NSLog(@"调用了2");
                self.gradeLabel.text = @"VIP会员";
                self.timeLabel.text = [UserDic objectForKey:@"end"];
            }else if([[UserDic objectForKey:@"payType"] isEqualToString:@"1"])
            {//支付宝付费
                self.gradeLabel.text = @"VIP会员";
                self.timeLabel.text = [UserDic objectForKey:@"end"];
            }
        }
    }else
    {
        self.gradeLabel.text = @"免费会员";
        self.timeLabel.text = @"永久";
    }
    
    
}

//切换用户
-(IBAction)switchUser:(id)sender{
    
    loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    [self.navigationController pushViewController:loginViewController animated:YES];
//    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)goBack:(id)sender{
    indexViewController = [[IndexViewController alloc] initWithNibName:@"IndexViewController" bundle:nil];
    [self.navigationController pushViewController:indexViewController animated:YES];
   // [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)changePwd:(id)sender{
    newPassword = [[NewPassword alloc] initWithNibName:@"NewPassword" bundle:nil];
    [self.navigationController pushViewController:newPassword animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [super dealloc];
}

@end
