//
//  RegisterViewController.h
//  TrafficQuery
//
//  Created by han zhen on 13-4-17.
//  Copyright (c) 2013年 hz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LoginViewController;
@interface RegisterViewController : UIViewController<UITextFieldDelegate>{
    UITextField* telphoneNum;
    UITextField* yanzhengNum;
    UITextField* passwordNum;
    UITextField* againPasswordNum;
    LoginViewController* loginViewController;
    UILabel* titleLabel;
    NSString* titleStr;
}
@property(nonatomic, copy)NSString* titleStr;
@property(nonatomic, retain)IBOutlet UILabel* titleLabel;
@property(nonatomic, retain)IBOutlet UITextField* telphoneNum;
@property(nonatomic, retain)IBOutlet UITextField* yanzhengNum;
@property(nonatomic, retain)IBOutlet UITextField* passwordNum;
@property(nonatomic, retain)IBOutlet UITextField* againPasswordNum;

-(IBAction)getYanZheng:(id)sender;
-(IBAction)goBack:(id)sender;
-(IBAction)registerNow:(id)sender;

@end
