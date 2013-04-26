//
//  LoginViewController.h
//  TrafficQuery
//
//  Created by han zhen on 13-4-17.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;
@class IndexViewController;
@class RegisterViewController;
@class UserViewController;

@interface LoginViewController : UIViewController<UITextFieldDelegate>{
    MBProgressHUD* HUD;
    UITextField* telphoneTextField;
    UITextField* passwordTextField;
    IndexViewController* indexViewController;
    RegisterViewController* registerViewController;
    UIImageView* backgroundImageView;
    UserViewController* userViewController;
}

@property(nonatomic, retain)IBOutlet UIImageView* backgroundImageView;
@property(nonatomic, retain)IBOutlet UITextField* telphoneTextField;
@property(nonatomic, retain)IBOutlet UITextField* passwordTextField;
-(IBAction)login:(id)sender;
-(IBAction)register:(id)sender;
-(IBAction)goBack:(id)sender;
-(IBAction)findPassword:(id)sender;

@end
